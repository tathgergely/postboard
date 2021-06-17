import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postboard/value/values.dart';

class RoundedTextField extends StatelessWidget {
  final TextFieldType textFieldType;
  final IconData? icon;
  final String hintText;
  final bool showErrorText;
  final Stream<String> stream;
  final Function(String) onChange;
  final TextEditingController? controller;
  RoundedTextField(
      {this.textFieldType = TextFieldType.Other,
      this.icon,
      this.hintText = "",
      this.showErrorText = false,
      required this.stream,
      required this.onChange,
      this.controller});

  @override
  Widget build(BuildContext context) {
    switch (textFieldType) {
      case TextFieldType.Password:
        return _PasswordTextField(
            icon, hintText, showErrorText, stream, onChange, controller);
      case TextFieldType.Number:
        return _NumberTextField(
            icon, hintText, showErrorText, stream, onChange, controller);
      default:
        return _OtherTextField(icon, hintText, showErrorText, stream, onChange, controller);
    }
  }
}

class _NumberTextField extends StatelessWidget {
  final IconData? icon;
  final String hintText;
  final bool showErrorText;
  final Stream<String> stream;
  final Function(String) onChange;
  final TextEditingController? controller;

  _NumberTextField(
      this.icon, this.hintText, this.showErrorText, this.stream, this.onChange, this.controller);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: stream,
      builder: (context, AsyncSnapshot<Object> snapshot) {
        return _TextFormFieldContainer(
          child: TextFormField(
            controller: this.controller !=null? controller : null,
            onChanged: (text) => onChange(text),
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              errorText: _showErrorMessage(snapshot, showErrorText),
              icon: icon != null
                  ? Icon(
                      icon,
                      color: kPrimaryColor,
                    )
                  : null,
              hintText: hintText,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          borderColor: snapshot.hasError ? kErrorBorderColor: kPrimaryLightColor,
        );
      },
    );
  }
}

class _OtherTextField extends StatelessWidget {
  final IconData? icon;
  final String hintText;
  final bool showErrorText;
  final Stream<String> stream;
  final Function(String) onChange;
  final TextEditingController? controller;
  _OtherTextField(
      this.icon, this.hintText, this.showErrorText, this.stream, this.onChange, this.controller);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: stream,
      builder: (context, AsyncSnapshot<Object> snapshot) {
        return _TextFormFieldContainer(
            child: TextFormField(
              controller: this.controller !=null? controller : null,
              onChanged: (String text) => onChange(text),
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                errorText: _showErrorMessage(snapshot, showErrorText),
                icon: icon != null
                    ? Icon(
                        icon,
                        color: kPrimaryColor,
                      )
                    : null,
                hintText: hintText,
              ),
            ),
            borderColor: snapshot.hasError ? kErrorBorderColor: kPrimaryLightColor);
      },
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  final IconData? icon;
  final String hintText;
  final bool showErrorText;
  final Stream<String> stream;
  final Function(String) onChange;
  final TextEditingController? controller;
  _PasswordTextField(
      this.icon, this.hintText, this.showErrorText, this.stream, this.onChange, this.controller);

  @override
  __PasswordTextFieldState createState() => __PasswordTextFieldState();
}

class __PasswordTextFieldState extends State<_PasswordTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: widget.stream,
      builder: (context, AsyncSnapshot<Object> snapshot) {
        return _TextFormFieldContainer(
            child: TextFormField(
              controller: widget.controller !=null? widget.controller : null,
              obscureText: _obscureText ? true : false,
              onChanged: (String text) => widget.onChange(text),
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                errorText: _showErrorMessage(snapshot, widget.showErrorText),
                icon: widget.icon != null
                    ? Icon(
                        widget.icon,
                        color: kPrimaryColor,
                      )
                    : null,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: kPrimaryColor,
                  ),
                ),
                hintText: widget.hintText,
              ),
            ),
            borderColor: snapshot.hasError ? kErrorBorderColor : kPrimaryLightColor);
      },
    );
  }
}

class _TextFormFieldContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;

  const _TextFormFieldContainer({
    Key? key,
    required this.child,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width,
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}

String? _showErrorMessage(AsyncSnapshot<Object> snapshot, bool showErrorText) {
  if (!showErrorText || !snapshot.hasError) return null;
  return snapshot.error.toString();
}

enum TextFieldType { Password, Number, Other }
