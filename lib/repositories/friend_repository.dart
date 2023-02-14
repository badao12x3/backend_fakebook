import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fakebook_frontend/models/request_received_friend_model.dart';
import 'package:fakebook_frontend/configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/list_friend_model.dart';

class FriendRepository {
  Future<ListFriend> friendsFetch() async {
    final url =
        Uri.http(Configuration.baseUrlConnect, '/account/get_list_friends');

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
          print(body);
          final friendList = ListFriend.fromJson(body);
          return friendList;
        }
      case 400:
        return ListFriend.initial();
      default:
        throw Exception('Error fetchRequestReceivedFriends');
    }
  }

  Future<ListFriend> friendOfAnotherUserFetched(String id) async {
    final url =
    Uri.http(Configuration.baseUrlConnect, '/account/get_list_friends',{
      'user_id': id,
    });

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
          final friendList = ListFriend.fromJson(body);
          return friendList;
        }
      case 400:
        return ListFriend.initial();
      default:
        throw Exception('Error fetchRequestReceivedFriends');
    }
  }
}
