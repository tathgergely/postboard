import 'dart:async';

import 'package:postboard/model/post.dart';
import 'package:postboard/model/profile.dart';
import 'package:postboard/service/authenticator.dart';
import 'package:postboard/service/dbhandler.dart';
import 'package:postboard/service/validator.dart';
import 'package:rxdart/rxdart.dart';

class BoardViewModel {
  BoardViewModel(this.user) {
    changeNewPostIsValid(false);
  }
  final Profile user;
  final _editText = BehaviorSubject<String>();
  final _editTextIsValid = BehaviorSubject<bool>();
  final _newPost = BehaviorSubject<String>();
  final _newPostIsValid = BehaviorSubject<bool>();

  Stream<bool> get newPostValid => _newPostIsValid.stream.transform(
      StreamTransformer<bool, bool>.fromHandlers(handleData: (data, sink) {
        sink.add(data);
      })
  );
  Stream<bool> get editTextIsValid => _editTextIsValid.stream.transform(
      StreamTransformer<bool, bool>.fromHandlers(handleData: (data, sink) {
        sink.add(data);
      })
  );
  Function(bool) get changeEditTextIsValid => _editTextIsValid.sink.add;
  Function(bool) get changeNewPostIsValid => _newPostIsValid.sink.add;
  bool isOutGoing (Post post) => (user.id == post.sender.id);

  Stream<String> get newPost =>
      _newPost.stream.transform(StreamTransformer<String, String>.fromHandlers(
          handleData: (post, sink) {
        if (!Validator.post(post)) {
          sink.addError("Invalid");
          changeNewPostIsValid(false);
        } else {
          sink.add(post);
          changeNewPostIsValid(true);
        }
      }));
  Function(String) get changeNewPost => _newPost.sink.add;

  Stream<String> get editText =>
      _editText.stream.transform(StreamTransformer<String, String>.fromHandlers(
          handleData: (post, sink) {
            if (!Validator.post(post)) {
              sink.addError("Invalid");
              changeEditTextIsValid(false);
            } else {
              sink.add(post);
              changeEditTextIsValid(true);
            }
          }));
  Function(String) get changeEditText => _editText.sink.add;

  Stream<List<Post>> get getPosts => DbHandler.getPosts();

  void deletePost(Post post)
  {
    DbHandler.remove(post);
  }
  void hidePost(Post post)
  {
    DbHandler.hide(post);
  }
  void revealPost(Post post)
  {
    DbHandler.reveal(post);
  }
  void editPost(Post post)
  {
    post.text=_editText.stream.value;
    DbHandler.edit(post);
  }
  Future submitNewPost() async {
    DbHandler.add(_newPost.stream.value, user,  DateTime.now());
  }
  void dispose() {
    _editText.close();
    _editTextIsValid.close();
    _newPost.close();
    _newPostIsValid.close();
  }
}
