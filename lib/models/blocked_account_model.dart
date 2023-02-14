// To parse this JSON data, do
//
//     final userHeader = userHeaderFromJson(jsonString);

import 'package:fakebook_frontend/models/user_header_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<BlockedAccount> blockedAccountsFromJson(String str) =>
    List<BlockedAccount>.from(
        json.decode(str).map((x) => BlockedAccount.fromJson(x)));

String blockedAccountsToJson(List<BlockedAccount> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlockedAccount {
  BlockedAccount({
    required this.userHeader,
    required this.createdAt,
  });

  final UserHeader userHeader;
  final String createdAt;

  BlockedAccount copyWith({
    UserHeader? userHeader,
    String? createdAt,
  }) =>
      BlockedAccount(
        userHeader: userHeader ?? this.userHeader,
        createdAt: createdAt ?? this.createdAt,
      );

  factory BlockedAccount.fromJson(Map<String, dynamic> json) => BlockedAccount(
      userHeader: UserHeader.fromJson(json['user']),
      createdAt: json['createdAt']);

  Map<String, dynamic> toJson() =>
      {"user": userHeader.toJson(), "createdAt": createdAt};
}
