import 'package:fakebook_frontend/routes.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:fakebook_frontend/models/local/models.dart';

import '../../../constants/localdata/user_data.dart';

class CreatePostContainer extends StatelessWidget {
  const CreatePostContainer({Key? key}): super(key: key);

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
              const SizedBox(width: 10.0),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.create_post_screen);
                  },
                  child: Container(
                    child: Text('Bạn đang nghĩ gì?', style: TextStyle(fontSize: 16)),
                  ),
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
