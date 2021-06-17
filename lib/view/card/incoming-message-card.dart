import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postboard/model/post.dart';
import 'package:postboard/view/element/circle-social-avatar.dart';

class IncomingMessageCard extends StatelessWidget {
  final CircleSocialAvatar avatar;
  final Post post;

  const IncomingMessageCard({
    required this.post,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: <Widget>[
          avatar,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${post.sender.displayName}",
                style: Theme.of(context).textTheme.caption,
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: post.hidden? Text("Hidden"): Text("${post.text}",
                    style: TextStyle(color: Colors.black87)),
              ),
              Text(DateFormat('MM. dd. – kk:mm').format(post.time),
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }
}
