import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postboard/model/post.dart';

class OutGoingMessageCard extends StatelessWidget {
  final Post post;

  const OutGoingMessageCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .6),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: post.hidden? Colors.purple:Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
            ),
            child: Text(
              "${post.text}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Text(DateFormat('MM. dd. – kk:mm').format(post.time),
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
