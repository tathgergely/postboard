import 'package:flutter/material.dart';
import 'package:postboard/model/profile.dart';
import 'package:postboard/view/board-fragment.dart';
import 'package:postboard/view/welcome-fragment.dart';
import 'package:postboard/viewmodel/board-viewmodel.dart';
import 'package:postboard/viewmodel/home-viewmodel.dart';
import 'package:provider/provider.dart';

import 'element/circle-social-avatar.dart';
import 'loading-page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      builder: (context, child) => _Body(Provider.of<HomeViewModel>(context)),
    );
  }
}

class _Body extends StatelessWidget {
  final HomeViewModel vm;

  _Body(this.vm);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: vm.user,
      builder: (context, AsyncSnapshot<Profile> snapshot) {
          if (snapshot.hasData) {
            final Profile user = snapshot.data!;

            return Scaffold(
                drawer: Drawer(
                    child: SafeArea(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: user.imageUrl != "asset"
                                    ? CircleSocialAvatar.url(
                                    imgUrl: user.imageUrl)
                                    : CircleSocialAvatar.asset(
                                    imageAsset: "assets/images/avatar.png"))
                              ,
                              Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      user.displayName,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    ),
                                    Text(
                                      user.email,
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                      Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text("Posts"),
                            onTap: () {
                              vm.setState(HomeFragmentState.Posts);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.logout),
                            title: Text("Logout"),
                            onTap: () {
                              vm.logout();
                            },
                          ),
                          Divider(),
                        ],
                      ),
                    ],
                  ),
                )),
                body: StreamBuilder(
                  stream: vm.homeState,
                  builder:
                      (context, AsyncSnapshot<HomeFragmentState> snapshot) {
                    if (snapshot.hasData) {
                      return _FragmentContainer(snapshot.data!, user);
                    } else {
                      return LoadingPage();
                    }
                  },
                ));
          }

        return LoadingPage();
      },
    );
  }
}

class _FragmentContainer extends StatelessWidget {
  HomeFragmentState state;
  Profile user;

  _FragmentContainer(this.state, this.user);

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case HomeFragmentState.Posts:
        return Provider(
          create: (context) => BoardViewModel(user),
          child: BoardFragment(),
        );
      default:
        return WelcomeFragment();
    }
  }
}
