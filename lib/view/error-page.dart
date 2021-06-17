import 'package:flutter/material.dart';
import 'package:postboard/value/values.dart';


class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Error!',
                  style: TextStyle(
                      fontSize: width * 0.2, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Please Restart',
                  style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
              ]
          )
      ),
    );
  }
}