import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fakebook_frontend/models/post_model.dart';
import 'package:fakebook_frontend/configuration.dart';

class PostRepository {

  Future<PostList> fetchPosts({int startIndex = 0, String? last_id}) async{
    // print("Fetching posts");
    const _postLimit = 5;
    final url = last_id != null ? Uri.http(Configuration.baseUrlPhysicalDevice2, '/post/get_list_posts', {'index': '$startIndex', 'count': '$_postLimit', 'last_id': '$last_id'})
    : Uri.http(Configuration.baseUrlPhysicalDevice2, '/post/get_list_posts', {'index': '$startIndex', 'count': '$_postLimit'});

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: Configuration.token,
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