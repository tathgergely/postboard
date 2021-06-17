import 'package:flutter/material.dart';
import 'package:postboard/value/values.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() press;
  final Color color, textColor, shadowColor;
  final bool isEnabled;
  final double width, height;

  RoundedButton(
      {required this.text,
      required this.press,
      this.isEnabled = true,
      this.width = double.infinity,
      this.height = 50,
      this.color = kPrimaryColor,
      this.textColor = Colors.white,
      this.shadowColor = kPrimaryShadowColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: height,
        child: ElevatedButton(
            child: Text(text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat')),
            onPressed: (isEnabled == true) ? press : null,
            style: ElevatedButton.styleFrom(
              primary: color,
              elevation: 7.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(32.0),
              ),
              shadowColor: shadowColor,
            )));
  }
}
