import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fakebook_frontend/models/request_received_friend_model.dart';
import 'package:fakebook_frontend/configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/personal_modal.dart';

class UserInfoRepository {
  Future<UserInfo> fetchPersonalInfo() async {
    print("#!#4Bắt đầu thực hiện fetchPersonalInfo()");
    final url =
        Uri.http(Configuration.baseUrlConnect, '/account/get_user_info');

    // get token from local storage/cache
    final prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user') ?? '{"token": "No userdata"}';
    Map<String, dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    final token = userMap['token'] != 'No userdata'
        ? userMap['token']
        : Configuration.token;

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token,
    });
    switch (response.statusCode) {
      case 200:
        {
          final body = json.decode(response.body) as Map<String, dynamic>;
          final userInfo = UserInfo.fromJson(body);
          print("#!#7Kết thúc thực hiện xong fetchPersonalInfo()");
          return userInfo;
        }
      case 400:
        return UserInfo.initial();
      default:
        throw Exception('Error fetchRequestReceivedFriends');
    }
  }

  Future<UserInfo> fetchPersonalInfoOfAnotherUser(String id) async {
    final url =
    Uri.http(Configuration.baseUrlConnect, '/account/get_user_info',{
      'user_id': id,
    });

    final prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user') ?? '{"token": "No userdata"}';
    Map<String, dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    final token = userMap['token'] != 'No userdata'
        ? userMap['token']
        : Configuration.token;

    final response = await http.get(url,
        headers: <String, String>{
          HttpHeaders.authorizationHeader: token,
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    switch (response.statusCode) {
      case 200:
        {
          final body = json.decode(response.body) as Map<String, dynamic>;
          final userInfo = UserInfo.fromJson(body);
          return userInfo;
        }
      case 400:
        return UserInfo.initial();
      default:
        throw Exception('Error fetchRequestReceivedFriends');
    }
  }
}
