import 'package:flutter/material.dart';

class CircleSocialAvatar extends StatelessWidget {
  late bool isAsset;
  late final String imgUrl;
  late final String imageAsset;
  CircleSocialAvatar.url({required this.imgUrl}){
    isAsset = false;
    imageAsset = "";
  }
  CircleSocialAvatar.asset({required this.imageAsset}){
    isAsset = true;
    imgUrl="";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(.3),
              offset: Offset(0, 2),
              blurRadius: 5)
        ],
      ),
      child: isAsset? CircleAvatar(
        foregroundImage: AssetImage("$imageAsset")
      ) : CircleAvatar(
        foregroundImage: NetworkImage("$imgUrl"),
      ),
    );
  }
}
