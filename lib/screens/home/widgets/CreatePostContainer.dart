import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:fakebook_frontend/models/Models.dart';

class CreatePostContainer extends StatelessWidget {
  final User currentUser;
  const CreatePostContainer({Key? key, required this.currentUser}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      color: Colors.white,
      // height: 200,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey[200],
                backgroundImage: CachedNetworkImageProvider(currentUser.imageUrl),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration.collapsed(hintText: 'Bạn đang nghĩ gì?'),
                ),
              ),
              TextButton.icon(
                  onPressed: () {print("image");},
                  icon: Icon(Icons.photo_library, color: Colors.green),
                  label: Text('Photos'),
              )
            ]
          )
        ]
      ),
    );
  }
}
