
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:postboard/model/profile.dart';

class Authenticator {

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static  Stream<bool> get isSignedIn =>
      firebaseAuth.authStateChanges().transform(
          StreamTransformer<User?, bool>.fromHandlers(handleData: (user, sink) {
        sink.add(user != null);
      }));

  static  Future<bool> linkFirebaseWithGoogleAccount() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null || FirebaseAuth.instance.currentUser == null)
      return false;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final OAuthCredential googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseAuth.instance.currentUser!
        .linkWithCredential(googleCredential)
        .then((value) => true);

    return false;
  }

  static signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await firebaseAuth.signInWithCredential(credential);
    } catch (error) {
      print(error);
    }
  }

  static signInWithFirebase(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (exception) {
      throw exception;
    }
  }

  static Future logout() async {
    var result = firebaseAuth.signOut();
    googleSignIn.signOut();
    return result;
  }

  static Stream<Profile> getLoggedInProfile() async* {

    if (firebaseAuth.currentUser == null) throw "Not logged in";
    User user = firebaseAuth.currentUser!;
    if(user.photoURL==null)
      {
        yield Profile(id: user.uid,email:user.email! ,displayName:user.displayName!);
      }
    else
      {
        yield Profile(id: user.uid,email:user.email! ,displayName:user.displayName!, imageUrl: user.photoURL!);
      }

  }
  static signUpWithFirebase(String email, String password, String displayName) async {
    try {
     await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((result) {
        result.user!.updateProfile(displayName: displayName, photoURL: '').then( (result2){
           firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        });
        
      });

    }
    catch (exception) {
      throw exception;
    }

  }
  static bool isAccountLinkedToGoogle() {
    final list= firebaseAuth.currentUser!.providerData;
    for(UserInfo info in list)
      {
        if(info.providerId=="google.com")
        {return true;}
      }
    return false;
  }


}
