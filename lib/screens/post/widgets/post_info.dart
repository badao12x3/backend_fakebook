import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostInfo extends StatelessWidget {
  final String avtUrl;
  final String name;

  const PostInfo({Key? key, required this.avtUrl, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22.0,
            backgroundImage: CachedNetworkImageProvider(avtUrl),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
                OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black45),
                      foregroundColor: Colors.black45,
                      splashFactory: NoSplash.splashFactory,
                      padding: EdgeInsets.all(8)
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.people, size: 16),
                    label: Text('Bạn bè')
                )
              ],
            ),
          )
        ]
      )
    );
  }


}
