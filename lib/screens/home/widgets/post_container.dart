import 'package:fakebook_frontend/constants/assets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:fakebook_frontend/models/models.dart';

class PostContainer extends StatelessWidget {
  final Post post;
  const PostContainer({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 _PostHeader(avtUrl: post.author.avatar, name: post.author.name, timeAgo: '58m'),
                  const SizedBox(height: 4),
                  Text(post.described)
                ]
            ),
          ),
          post.images != null ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child:  CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: post.images?.elementAt(0).url ?? ImagePlaceHolder.imagePlaceHolderOnline,
                  errorWidget: (context, url, error) => const Image(
                    image: AssetImage('assets/images/placeholder_image.png'),
                    width: 200,
                    height: 200)
              )
          ) : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _PostStats(likes: post.likes, comments: post.comments, shares: 0),
          )
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final String avtUrl;
  final String name;
  final String timeAgo;
  const _PostHeader({Key? key, required this.avtUrl, required this.name, required this.timeAgo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: CircleAvatar(
            radius: 22.0,
            backgroundImage: CachedNetworkImageProvider(avtUrl)
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
              Row(
                children: [
                  Text('$timeAgo \u00B7 ', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  Icon(Icons.public,color: Colors.grey[600], size: 12)
                ],
              )
            ],
          ),
        ),
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.more_horiz),
          onPressed: (){},
        )
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  final int likes;
  final int comments;
  final int shares;
  const _PostStats({Key? key, required this.likes, required this.comments, required this.shares}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Palette.facebookBlue,
                shape: BoxShape.circle
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                '${likes}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Text(
              '${comments} bình luận',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${shares} lượt chia sẻ',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: _PostButton(
                icon: Icon(MdiIcons.thumbUpOutline, color: Colors.grey[600], size: 20),
                label: 'Thích',
                onTap: (){},
              ),
            ),
            Expanded(
              child: _PostButton(
                icon: Icon(MdiIcons.commentOutline, color: Colors.grey[600], size: 20),
                label: 'Bình luận',
                onTap: (){},
              ),
            ),
            Expanded(
              child: _PostButton(
                icon: Icon(MdiIcons.shareOutline, color: Colors.grey[600], size: 25),
                label: 'Chia sẻ',
                onTap: (){},
              ),
            )
          ],
        )
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback onTap;
  const _PostButton({Key? key, required this.icon, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 4),
              Text(label)
            ],
          ),
        ),
      ),
    );
  }
}



