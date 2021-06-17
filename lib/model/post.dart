import 'package:json_annotation/json_annotation.dart';
import 'package:postboard/model/profile.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post{
  String id;
  String text;
  Profile sender;
  DateTime time;
  bool hidden;
  Post({required this.id, required this.text, required this.sender, required this.time, this.hidden = false});

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}