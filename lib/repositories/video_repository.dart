import 'dart:convert';
import 'dart:io';

import '../configuration.dart';
import '../models/video_model.dart';
import '../utils/token.dart';
import 'package:http/http.dart' as http;

class VideoRepository {
  getListVideo() async {
    try{
      var token = await Token.getToken();
      final url = Uri.http(Configuration.baseUrlConnect, 'video/get_list_videos');
      final response = await http.get(
          url,
          headers: <String, String>{
            HttpHeaders.authorizationHeader: token,
            'Content-Type': 'application/json; charset=UTF-8',
          }
      );
      final body = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        final postList = VideoList.fromJson(body['data']);
        return postList;
      } else if (response.statusCode == 400) {
        if (body['code'] == '9993') {
          // message: Video is not exsist
          return VideoList.initial();
        }
      } else {
        return VideoList.initial();
      }
    }catch(error){
      throw Exception('${error} - Error to get list video');
    }
  }
}