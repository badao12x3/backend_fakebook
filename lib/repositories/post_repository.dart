import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fakebook_frontend/models/post_model.dart';
import 'package:fakebook_frontend/configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepository {

  Future<PostList> fetchPosts({int startIndex = 0, String? last_id}) async {
    // print("Fetching posts");
    const _postLimit = 5;
    final url = last_id != null ? Uri.http(Configuration.baseUrlConnect, '/post/get_list_posts', {'index': '$startIndex', 'count': '$_postLimit', 'last_id': '$last_id'})
    : Uri.http(Configuration.baseUrlConnect, '/post/get_list_posts', {'index': '$startIndex', 'count': '$_postLimit'});

    // get token from local storage/cache
    final prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user') ?? '{"token": "No userdata"}';
    Map<String,dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    // print("#Post_repository: " + userMap.toString());
    final token = userMap['token'] != 'No userdata' ? userMap['token'] : Configuration.token;
    // print("#Post_repository: " +  token.toString());

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token,
    });
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;
      final postList = PostList.fromJson(body);
      return postList;
    }else if (response.statusCode == 400) {
      return PostList.initial();
    }
    throw Exception('Error fetching posts');
  }

}