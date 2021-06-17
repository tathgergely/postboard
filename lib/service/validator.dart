import 'dart:async';

import 'package:email_validator/email_validator.dart';

class Validator {
  static final _passwordMinLength = 8;
  static final _passwordMaxLength = 32;

  static final _displayNameMinLength = 5;
  static final _displayNameMaxLength = 15;

  static final _postMinLength = 5;
  static final _postMaxLength = 500;

  static bool email(String? email) {
    if (email == null) return false;
    return EmailValidator.validate(email);
  }

  static bool password(String? password) {
    if (password == null || password.isEmpty) return false;
    return (password.length <= _passwordMaxLength &&
        password.length >= _passwordMinLength);
  }

  static bool displayName(String? displayName) {
    if (displayName == null || displayName.isEmpty) return false;
    final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');

    return (displayName.length <= _displayNameMaxLength &&
        displayName.length >= _displayNameMinLength &&
        validCharacters.hasMatch(displayName));
  }

  static bool post(String? post) {
    if (post == null || post.isEmpty) return false;

    return (post.length <= _postMaxLength && post.length >= _postMinLength);
  }

  static final emailTransformer =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (!Validator.email(email)) {
      sink.addError("Invalid");
    } else {
      sink.add(email);
    }
  });



  static final passwordTransformer =
  StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    if (!Validator.password(password)) {
      sink.addError("Invalid");
    } else {
      sink.add(password);
    }
  });
}
