import 'dart:io';

import 'package:fakebook_frontend/models/like_post_model.dart';
import 'package:fakebook_frontend/utils/token.dart';
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
    var token = await Token.getToken();
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

  // Future<LikePostModel> likeHomePost({required String id}) async {
  //   try {
  //     var token = await Token.getToken();
  //     final url = Uri.http(Configuration.baseUrlConnect, 'post/like_post');
  //     final response = await http.post(url,
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: jsonEncode(<String, dynamic>{
  //           'id': id
  //         })
  //     );
  //     if (response.statusCode == 200) {
  //       final body = json.decode(response.body) as Map<String, dynamic>;
  //       return LikePostModel.fromJson(body);
  //     } else if (response.statusCode == 400) {
  //       final body = json.decode(response.body) as Map<String, dynamic>;
  //       return LikePostModel.nullData();
  //     }
  //   } catch(error) {
  //     throw Exception("${error} - Error to like post");
  //   }
  // }
}