import 'dart:async';

import 'package:postboard/service/authenticator.dart';
import 'package:postboard/service/validator.dart';
import 'package:rxdart/rxdart.dart';

class RegisterViewModel
{
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _displayName = BehaviorSubject<String>();

  Stream<String> get email => _email.stream.transform(validateEmail);

  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<String> get displayName =>
      _displayName.stream.transform(validateDisplayName);

  Stream<bool> get signUpValid =>
      Rx.combineLatest3(email, password, displayName, (e, p, d) => true);

  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Function(String) get changeDisplayName => _displayName.sink.add;

  String get _getEmailString => _email.stream.value;

  String get _getPasswordString => _password.stream.value;

  String get _getDisplayNameString => _displayName.stream.value;

  dispose() {
    _email.close();
    _password.close();
    _displayName.close();
  }

  final validateEmail =
  StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (!Validator.email(email)) {
      sink.addError("Invalid");
    } else {
      sink.add(email);
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (!Validator.password(password)) {
          sink.addError("Invalid");
        } else {
          sink.add(password);
        }
      });

  final validateDisplayName = StreamTransformer<String, String>.fromHandlers(
      handleData: (displayName, sink) {
        if (!Validator.displayName(displayName)) {
          sink.addError("Invalid");
        } else {
          sink.add(displayName);
        }
      });

  Future submitRegisterForm() async {
    try{
      await Authenticator.signUpWithFirebase(
          _getEmailString, _getPasswordString, _getDisplayNameString);
    }
    catch(exception, stack)
    {
      throw exception;
    }

  }
}