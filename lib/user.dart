import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'user.g.dart';

@JsonSerializable()
class User{
  User(this.name, this.email);

  String name;
  String email;

  // _$UserFromJsonが生成される
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // _$UserToJsonが生成される
  Map<String, dynamic> toJson() => _$UserToJson(this);
}















