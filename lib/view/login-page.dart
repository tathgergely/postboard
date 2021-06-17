import 'package:flutter/material.dart';
import 'package:postboard/service/notifier.dart';
import 'package:postboard/value/values.dart';
import 'package:postboard/viewmodel/login-viewmodel.dart';
import 'package:provider/provider.dart';

import 'element/rounded-button.dart';
import 'element/rounded-textfield.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      builder: (context, child) => _Body(Provider.of<LoginViewModel>(context)),
    );
  }
}

class _Body extends StatelessWidget {
  final LoginViewModel vm;

  _Body(this.vm);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(children: <Widget>[
                new Flexible(
                  child: Container(
                    padding: EdgeInsets.all(0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Sign',
                            style: TextStyle(
                                fontSize: 100, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'In',
                            style: TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ]),
                  ),
                  flex: 4,
                ),
                new Flexible(
                  child: SizedBox(height: 100),
                  flex: 1,
                ),
                new Flexible(
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: Column(children: <Widget>[
                              RoundedTextField(
                                  icon: Icons.email,
                                  hintText: "Email",
                                  stream: vm.email,
                                  onChange: vm.changeEmail),
                              RoundedTextField(
                                  icon: Icons.lock,
                                  hintText: "Password",
                                  textFieldType: TextFieldType.Password,
                                  stream: vm.password,
                                  onChange: vm.changePassword),
                            ])),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),

                        Container(
                            child: Column(children: <Widget>[
                              StreamBuilder(
                                stream: vm.loginValid,
                                builder: (context,
                                    AsyncSnapshot<bool> snapshot) {
                                  return RoundedButton(
                                      text: "Login",
                                      isEnabled:
                                      snapshot.hasData ? snapshot.data! : false,
                                      press: () {
                                        vm
                                            .submitLoginForm()
                                            .onError((error, stackTrace) {
                                          Notifier.showSnackBar(context, error);
                                        });
                                      });
                                },
                              ),
                              SizedBox(height: 20.0),
                              RoundedButton(
                                text: "Log in with Google",
                                press: () {
                                  vm.signInWithGoogle;
                                },
                              ),
                              SizedBox(height: 15.0),
                            ])),
                      ],
                    ),
                    flex: 10)
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
