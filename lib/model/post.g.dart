// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as String,
    text: json['text'] as String,
    sender: Profile.fromJson(json['sender'] as Map<String, dynamic>),
    time: DateTime.parse(json['time'] as String),
    hidden: json['hidden'] as bool,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'sender': instance.sender.toJson(),
      'time': instance.time.toIso8601String(),
      'hidden': instance.hidden,
    };
