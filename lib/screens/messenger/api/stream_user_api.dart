import 'package:fakebook_frontend/models/user_chat_model.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamUserApi {
  static Future<List<UserChat>> getAllUser({bool includeMe = false, required StreamChatClient client}) async {
    final sort = SortOption('last_message_at');
    final response = await client.queryUsers(sort: [sort]);

    final defaultImage =
        'https://images.unsplash.com/photo-1580907114587-148483e7bd5f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
    final allUsers = response.users.map((user) => UserChat(
        idUser: user.id,
        name: user.name,
        imageUrl: user.extraData['image'].toString() ?? defaultImage,
        isOnline: user.online
    )).toList();

    return allUsers;
  }
}