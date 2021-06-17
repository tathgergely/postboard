
import 'package:flutter/material.dart';
import 'package:postboard/value/values.dart';

class WelcomeFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome to',
                    style: TextStyle(
                        fontSize: width * 0.1, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'PostBoard',
                    style: TextStyle(
                        fontSize: width * 0.1,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                ])),
      ),
    );
  }
}
