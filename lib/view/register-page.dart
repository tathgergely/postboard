import 'package:flutter/material.dart';
import 'package:postboard/service/authenticator.dart';
import 'package:postboard/service/notifier.dart';
import 'package:postboard/value/values.dart';
import 'package:postboard/viewmodel/register-viewmodel.dart';
import 'package:provider/provider.dart';

import 'element/rounded-button.dart';
import 'element/rounded-textfield.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Body(Provider.of<RegisterViewModel>(context));
  }
}

class _Body extends StatelessWidget {
  final RegisterViewModel vm;

  _Body(this.vm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Text(
                        'Sign',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Up',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ])),
                Center(
                  child: Column(children: <Widget>[
                    RoundedTextField(
                      icon: Icons.account_circle,
                      hintText: "Display Name",
                      stream: vm.displayName,
                      onChange: vm.changeDisplayName,
                    ),
                    SizedBox(height: 10.0),
                    RoundedTextField(
                      icon: Icons.email,
                      hintText: "Email Address",
                      stream: vm.email,
                      onChange: vm.changeEmail,
                    ),
                    SizedBox(height: 10.0),
                    RoundedTextField(
                      hintText: "Password",
                      textFieldType: TextFieldType.Password,
                      stream: vm.password,
                      onChange: vm.changePassword,
                      icon: Icons.lock,
                    ),
                    SizedBox(height: 50.0),
                    StreamBuilder(
                      stream: vm.signUpValid,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        return RoundedButton(
                            text: "Sign Up",
                            isEnabled:
                                snapshot.hasData ? snapshot.data! : false,
                            press: () {
                              vm
                                  .submitRegisterForm()
                                  .then((value){
                                    Authenticator.logout();
                                    Navigator.pop(context);
                              })
                                  .catchError((error, stackTrace) {
                                Notifier.showSnackBar(context, error);
                              });
                            });
                      },
                    ),
                    SizedBox(height: 20.0),
                    RoundedButton(
                      text: "Go Back",
                      press: () {
                        Navigator.pop(context);
                      },
                    )
                  ]),
                )
              ],
            ),
          ),
        )));
  }
}
