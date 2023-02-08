import 'dart:io';

import 'package:fakebook_frontend/models/like_post_model.dart';
import 'package:fakebook_frontend/models/post_detail_model.dart';
import 'package:fakebook_frontend/utils/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fakebook_frontend/models/post_model.dart';
import 'package:fakebook_frontend/configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepository {

  Future<PostList> fetchPosts({int startIndex = 0, String? last_id}) async {
    try {
      // print("Fetching posts");
      const _postLimit = 5;
      final url = last_id != null ? Uri.http(
          Configuration.baseUrlConnect, '/post/get_list_posts', {
        'index': '$startIndex',
        'count': '$_postLimit',
        'last_id': '$last_id'
      })
          : Uri.http(Configuration.baseUrlConnect, '/post/get_list_posts',
          {'index': '$startIndex', 'count': '$_postLimit'});

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
      } else if (response.statusCode == 400) {
        return PostList.initial();
      } else {
        return PostList.initial();
      }
    } catch(error) {
      throw Exception('Error fetching posts');
    }

  }

  Future<LikePost> likeHomePost({required String id}) async {
    try {
      var token = await Token.getToken();
      final url = Uri.http(Configuration.baseUrlConnect, 'post/like_post');
      final response = await http.post(url,
          headers: <String, String>{
            HttpHeaders.authorizationHeader: token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id': id
          })
      );
      final body = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return LikePost.fromJson(body);
      } else if (response.statusCode == 400) {
        if (body['code'] == '506') {
          // message: Has been liked
          return LikePost.nullData().copyWith(code: body['code'], message: body['message']);
        } else if (body['code'] == '9991') {
          // message: Post is banned
          return LikePost.nullData().copyWith(code: body['code'], message: body['message']);
        } else {
          return LikePost.nullData();
        }
      } else if (response.statusCode == 403) {
        // Không like được do mình block nó hoặc nó block mình
        if (body['details'] == 'Người viết đã chặn bạn / Bạn chặn người viết, do đó không thể like bài viết') {
          return LikePost.nullData().copyWith(code: body['code'], message: 'Người viết đã chặn bạn / Bạn chặn người viết, do đó không thể like bài viết');
        }
        // Tài khoản bị khóa
        return LikePost.nullData().copyWith(code: body['code'], message: body['message']);
      } else {
        return LikePost.nullData();
      }
    } catch(error) {
      throw Exception('${error} - Error to like post');
    }
  }

  Future<LikePost> unlikeHomePost({required String id}) async {
    try {
      var token = await Token.getToken();
      final url = Uri.http(Configuration.baseUrlConnect, 'post/unlike_post');
      final response = await http.post(url,
          headers: <String, String>{
            HttpHeaders.authorizationHeader: token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id': id
          })
      );
      final body = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return LikePost.fromJson(body);
      } else if (response.statusCode == 400) {
        if (body['code'] == '506') {
          // message: Has been unliked
          return LikePost.nullData().copyWith(code: body['code'], message: body['message']);
        } else if (body['code'] == '9991') {
          // message: Post is banned
          return LikePost.nullData().copyWith(code: body['code'], message: body['message']);
        } else {
          return LikePost.nullData();
        }
      } else if (response.statusCode == 403) {
        // message: Not access - Tài khoản bị khóa
        return LikePost.nullData().copyWith(code: body['code'], message: body['message']);
      } else {
        return LikePost.nullData();
      }
    } catch(error) {
      throw Exception('${error} - Error to unlike post');
    }
  }

  Future<PostDetail?> fetchDetailPost({required String postId}) async {
    final url = Uri.http(Configuration.baseUrlConnect, '/post/get_post/$postId');

    var token = await Token.getToken();

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token,
    });

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;
      final postDetail = PostDetail.fromJson(body['data']);
      return postDetail;
    } else if (response.statusCode == 400) {
      return null;
    } else {
      return null;
    }
  }

}