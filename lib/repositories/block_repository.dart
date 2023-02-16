import 'dart:io';

import 'package:fakebook_frontend/models/blocked_account_model.dart';
import 'package:fakebook_frontend/models/like_post_model.dart';
import 'package:fakebook_frontend/models/post_detail_model.dart';
import 'package:fakebook_frontend/utils/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fakebook_frontend/models/post_model.dart';
import 'package:fakebook_frontend/configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlockRepository {
  Future<List<BlockedAccount>?> fetchBlock() async {
    final url =
        Uri.http(Configuration.baseUrlConnect, '/account/get_blocked_account');

    var token = await Token.getToken();

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token,
    });

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;
      final Data = body["data"]["blockedAccounts"] as List<dynamic>?;
      List<BlockedAccount>? blockedAccounts =
          Data?.map((block) => BlockedAccount.fromJson(block)).toList();

      // print("checc $blockedAccounts");
      return blockedAccounts;
    } else if (response.statusCode == 400) {
      return null;
    } else {
      return null;
    }
  }

  Future<dynamic> blockById({required String id}) async {
    try {
      var token = await Token.getToken();
      final url = Uri.http(Configuration.baseUrlConnect, 'account/block_by_id');
      final response = await http.post(url,
          headers: <String, String>{
            HttpHeaders.authorizationHeader: token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{'id': id}));
      final body = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        return false;
      }
    } catch (error) {
      throw Exception('${error} - Error to like post');
    }
    return false;
  }

  Future<dynamic> removeBlockById({required String id}) async {
    try {
      var token = await Token.getToken();
      final url =
          Uri.http(Configuration.baseUrlConnect, 'account/remove_block_by_id');
      final response = await http.post(url,
          headers: <String, String>{
            HttpHeaders.authorizationHeader: token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{'id': id}));
      final body = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        return false;
      }
    } catch (error) {
      throw Exception('${error} - Error to like post');
    }
    return false;
  }
}
