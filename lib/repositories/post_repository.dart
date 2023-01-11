import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fakebook_frontend/models/post_model.dart';
import 'package:fakebook_frontend/configuration.dart';

class PostRepository {

  Future<PostList> fetchPosts({int startIndex = 0}) async{
    // print("Fetching posts");
    const _postLimit = 20;
    final url = Uri.http(Configuration.baseUrl, '/post/get_list_posts', {'index': '$startIndex', 'count': '$_postLimit'});
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: Configuration.token,
    });
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;
      final postList = PostList.fromJson(body);
      return postList;
    }
    throw Exception('Error fetching posts');
  }

}