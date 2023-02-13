import 'package:fakebook_frontend/screens/notification/widgets/action_container.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:fakebook_frontend/models/local/models.dart';

class NotificationContainer extends StatelessWidget {
  static final Map<String, String> actionDes = {'like': ' đã thích bài viết của bạn.', 'comment': ' đã bình luận về bài viết của bạn.'};

  final String name;
  final String action;
  final String avtUrl;
  final String timeAgo;
  final bool read;
  const NotificationContainer(
      {Key? key,
      required this.name,
      required this.avtUrl,
      required this.action,
      required this.timeAgo,
      required this.read})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      // child: IntrinsicHeight(
      child: Container(
        color: read ? Colors.white : Colors.blue.shade50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(5, 2, 8, 2),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: CachedNetworkImageProvider(avtUrl),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: ActionContainer(action: action),
                    )
                  ],
                )),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      overflow: TextOverflow.clip,
                      text: TextSpan(
                        text: name,
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        children: [
                          TextSpan(
                          text: actionDes[action],
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16)
                          )])),
                    Text(timeAgo,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(fontSize: 13, color: Palette.grey1))
                  ])),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () => {},
                ))])));
}}
