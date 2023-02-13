import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:fakebook_frontend/configuration.dart';
import 'package:fakebook_frontend/models/comment_model.dart';
import '../utils/token.dart';

class CommentRepository {
  Future<List<Comment>?> fetchComments({required String postId}) async {
    final url = Uri.http(Configuration.baseUrlConnect, '/comment/get_comment', {'id': postId});

    var token = await Token.getToken();

    final response = await http.get(url,
        headers: {
          HttpHeaders.authorizationHeader: token,
        }
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;
      final commentsData = body["data"]["commentList"] as List<dynamic>?;
      List<Comment>? comments = commentsData?.map((cmt) => Comment.fromJson(cmt)).toList();
      return comments;
    } else if (response.statusCode == 400) {
      return null;
    } else {
      return null;
    }
  }

}