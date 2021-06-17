import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:postboard/model/post.dart';
import 'package:postboard/model/profile.dart';

class DbHandler {
  static final _postsCollection =
      FirebaseFirestore.instance.collection("posts");

  static Future add(String text, Profile user, DateTime now) async {
    String id= _postsCollection.doc().id;
    Post post = Post(id: id, text: text, sender: user, time: now);
    _postsCollection.doc(id).set(post.toJson());

  }
  static remove(Post post)
  {
    _postsCollection.doc(post.id).delete();
  }
  static edit(Post post)
  {
    _postsCollection.doc(post.id).update(post.toJson());
  }
  static hide(Post post)
  {
    _postsCollection.doc(post.id).update({
      'hidden' : true
    });
  }
  static reveal(Post post)
  {
    _postsCollection.doc(post.id).update({
      'hidden' : false
    });
  }
  static Stream<List<Post>> getPosts() {

    return _postsCollection.orderBy('time').snapshots().transform(postsTransformer);
  }

  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<Post>> postsTransformer = StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<Post>>.fromHandlers(
      handleData: (query, sink)
      {
        sink.add(query.docs.map((e) {return Post.fromJson(e.data());} ).toList());
      }
  );
}
