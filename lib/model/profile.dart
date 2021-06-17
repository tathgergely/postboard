import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(includeIfNull: true)
class Profile {
String id, email, displayName;
String imageUrl;


Profile({required this.id, required this.email, required this.displayName, this.imageUrl="asset"});

  factory Profile.fromJson(Map<String, dynamic> json) =>
    _$ProfileFromJson(json);

Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
