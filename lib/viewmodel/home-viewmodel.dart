import 'dart:async';

import 'package:postboard/model/post.dart';
import 'package:postboard/model/profile.dart';
import 'package:postboard/service/authenticator.dart';
import 'package:postboard/service/dbhandler.dart';
import 'package:postboard/service/validator.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel {


  HomeViewModel() {
    _homeFragmentState.sink.add(HomeFragmentState.Welcome);
  }

  final _user = BehaviorSubject<Profile>();
  final _homeFragmentState = BehaviorSubject<HomeFragmentState>();


  Stream<HomeFragmentState> get homeState => _homeFragmentState.stream;
  Stream<Profile> get user => Authenticator.getLoggedInProfile();






  logout() => Authenticator.logout();

  void dispose() {
    _homeFragmentState.close();

    _user.close();
  }

  setState(HomeFragmentState editProfile) {
    _homeFragmentState.sink.add(editProfile);
  }
}

enum HomeFragmentState {
  Welcome,
  Posts,
  Logout
}
