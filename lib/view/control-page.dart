import 'package:flutter/material.dart';
import 'package:postboard/viewmodel/control-viewmodel.dart';
import 'package:provider/provider.dart';

import 'home-page.dart';
import 'loading-page.dart';
import 'login-page.dart';

class ControlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return  _Body(Provider.of<ControlViewModel>(context));
  }
}

class _Body extends StatelessWidget {
  final ControlViewModel vm;

  _Body(this.vm);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: vm.isSignedIn,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            print("isSignedIn: "+snapshot.data!.toString());
            return (snapshot.data! ==true) ? HomePage() : LoginPage();
          }
        }
        return LoadingPage();
      },
    );
  }
}
