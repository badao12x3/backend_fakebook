import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fakebook_frontend/models/request_received_friend_model.dart';
import 'package:fakebook_frontend/configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendRequestReceivedRepository {
  Future<FriendRequestReceivedList> fetchRequestReceivedFriends(
      {String? cur_id}) async {
    final url = Uri.http(Configuration.baseUrlConnect,
        '/account/get_requested_friends', {'_id': '$cur_id'});

    // get token from local storage/cache
    final prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user') ?? '{"token": "No userdata"}';
    Map<String, dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    // print("#Post_repository: " + userMap.toString());
    final token = userMap['token'] != 'No userdata'
        ? userMap['token']
        : Configuration.token;
    // print("#Post_repository: " +  token.toString());

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token,
    });
    switch (response.statusCode) {
      case 200:
        {
          final body = json.decode(response.body) as Map<String, dynamic>;
          final friendRequestReceivedList =
              FriendRequestReceivedList.fromJson(body);
          return friendRequestReceivedList;
        }
      case 400:
        return FriendRequestReceivedList.initial();
      default:
        throw Exception('Error fetchRequestReceivedFriends');
    }
  }
}
