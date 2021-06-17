
import 'dart:async';

import 'package:postboard/service/authenticator.dart';
import 'package:postboard/service/validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel{
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Stream<String> get email => _email.stream.transform(Validator.emailTransformer);
  Function(String) get changeEmail => _email.sink.add;

  Stream<String> get password => _password.stream.transform(Validator.passwordTransformer);
  Function(String) get changePassword => _password.sink.add;

  Stream<bool> get loginValid => Rx.combineLatest2(email, password, (e, p) => true);


  void get signInWithGoogle => Authenticator.signInWithGoogle();

  dispose() {
    _email.close();
    _password.close();
  }

  Future submitLoginForm() async {
    await Authenticator.signInWithFirebase(_email.stream.value, _password.stream.value)
        .timeout(Duration(seconds: 3))
        .onError((error, stackTrace) => throw error!);
  }

}