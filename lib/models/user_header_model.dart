// To parse this JSON data, do
//
//     final userHeader = userHeaderFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserHeader userHeaderFromJson(String str) =>
    UserHeader.fromJson(json.decode(str));

String userHeaderToJson(UserHeader data) => json.encode(data.toJson());

class UserHeader {
  UserHeader({
    required this.id,
    required this.name,
    required this.avatar,
  });

  final String id;
  final String name;
  final String avatar;

  UserHeader copyWith({
    String? id,
    String? name,
    String? avatar,
  }) =>
      UserHeader(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
      );

  factory UserHeader.fromJson(Map<String, dynamic> json) => UserHeader(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
      };
}
