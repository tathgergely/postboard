import 'package:flutter/material.dart';
import 'package:postboard/model/post.dart';
import 'package:postboard/viewmodel/board-viewmodel.dart';

import 'element/rounded-button.dart';
import 'element/rounded-textfield.dart';

class EditFragment extends StatelessWidget {
  final BoardViewModel vm;
  final Post post;
  late final  TextEditingController controller;
  EditFragment(this.vm, this.post)
  {
    controller = TextEditingController(text: post.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                new Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Column(children: <Widget>[
                          RoundedTextField(
                              icon: Icons.keyboard,
                              controller: controller,
                              stream: vm.editText,
                              onChange: vm.changeEditText),
                        ])),
                        Row(
                          children: [
                            new Flexible(
                                child: RoundedButton(
                                    text: "Cancel",
                                    press: () {
                                      Navigator.pop(context);
                                    }),
                                flex: 1),
                            new Flexible(
                                child: StreamBuilder(
                                    stream: vm.editTextIsValid,
                                    builder: (context,
                                        AsyncSnapshot<bool> snapshot) {
                                      return RoundedButton(
                                          text: "Edit",
                                          isEnabled: snapshot.hasData
                                              ? snapshot.data!
                                              : false,
                                          press: () {
                                            vm.editPost(post);
                                            Navigator.pop(context);
                                          });
                                    }),
                                flex: 1),
                          ],
                        )
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
