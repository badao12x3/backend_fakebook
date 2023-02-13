import 'package:fakebook_frontend/blocs/post/post_bloc.dart';
import 'package:fakebook_frontend/blocs/post/post_event.dart';
import 'package:fakebook_frontend/constants/assets/placeholder.dart';
import 'package:fakebook_frontend/routes.dart';
import 'package:fakebook_frontend/screens/home/widgets/home_widgets.dart';
import 'package:fakebook_frontend/screens/personal/personal_screen.dart';
import 'package:fakebook_frontend/screens/watch/watch_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:fakebook_frontend/models/models.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../blocs/personal_post/personal_post_bloc.dart';
import '../../../blocs/personal_post/personal_post_event.dart';

class PostContainer extends StatelessWidget {
  final Post post;
  const PostContainer({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("#PostContainer: Rebuild ${post.id}");

    // tính timeAgo
    DateTime dt1 = DateTime.now();
    DateTime dt2 = DateTime.parse(post.updatedAt);
    final Duration diff = dt1.difference(dt2);
    final String timeAgo = diff.inDays == 0 ? "${diff.inHours}h" : "${diff.inDays}d";

    void handleLikePost() {
      // print("#PostContainer: Like post: ${post.id}");
      // Bị vấn đề là dùng chung PostContainer và khi state của 1 trong 2 cái chưa load hết mà update thì sẽ khả năng lỗi mảng cao
      // Đã sửa bằng cách fix if(indexOfMustUpdatePost == -1) return; ---> nhưng chỉ update được 1 trong 2 cái, 1 cái còn lại luôn báo lỗi không thấy mảng -1 dù cả 2 đã load hết state ---> Tạm chấp nhận được
      BlocProvider.of<PostBloc>(context).add(PostLike(post: post));
      BlocProvider.of<PersonalPostBloc>(context).add(PersonalPostLike(post: post));
    }

    void handleOtherPostEvent(Map event) {
      if(event['action'] == 'navigateToDetailPost') {
        // print(post.id);
        Navigator.pushNamed(context, Routes.post_detail_screen, arguments: post.id);
      } else if (event['action'] == 'navigateToPersonalScreen') {
        Navigator.pushNamed(context, Routes.personal_screen, arguments: post.author.id);
      }
    }
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
                 _PostHeader(avtUrl: post.author.avatar, name: post.author.name, timeAgo: timeAgo, status: post.status, onHandleOtherPostEvent: (event) => handleOtherPostEvent(event)),
                  const SizedBox(height: 4),
                  Text(post.described)
                ]
            ),
          ),
          const SizedBox(height: 4),
          post.images != null ?
          Container(
            height: 200,
            child: GridView.count(
                padding: EdgeInsets.all(0),
                crossAxisCount: post.images?.length == 1 ? 1 : 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: post.images!.map((image) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: CachedNetworkImage(
                          placeholder: (context, url) => CircularProgressIndicator(),
                          imageUrl: image.url ?? ImagePlaceHolder.imagePlaceHolderOnline,
                          errorWidget: (context, url, error) => const Image(
                              image: AssetImage('assets/images/placeholder_image.png'),
                              width: 200,
                              height: 200)
                      )
                  );
                }).toList(),
            ),
          )
          : const SizedBox.shrink(),
          post.video != null ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: PostVideoContainer(url: post.video?.url ?? VideoPlaceHolder.videoPlaceHolderOnline),
          ) : const SizedBox.shrink(),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _PostStats(likes: post.likes, comments: post.comments, shares: 0, isLiked: post.isLiked, onLikePost: handleLikePost, onHandleOtherPostEvent: (event) => handleOtherPostEvent(event)),
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
  final String? status;
  final Function(Map event)? onHandleOtherPostEvent;
  const _PostHeader({Key? key, required this.avtUrl, required this.name, required this.timeAgo, this.status, this.onHandleOtherPostEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            onHandleOtherPostEvent?.call({'action': 'navigateToPersonalScreen'});
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: CircleAvatar(
              radius: 22.0,
              backgroundImage: CachedNetworkImageProvider(avtUrl)
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  onHandleOtherPostEvent?.call({'action': 'navigateToPersonalScreen'});
                },
                child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: '$name ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
                        if(status != null) TextSpan(text: 'hiện đang cảm thấy ',  style: TextStyle(color: Colors.black, fontSize: 16)),
                        if(status != null) TextSpan(text: '$status', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis
                ),
              ),
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
  final bool isLiked;
  final Function() onLikePost;
  final Function(Map event)? onHandleOtherPostEvent;

  const _PostStats({Key? key, required this.likes, required this.comments, required this.shares, required this.isLiked, required this.onLikePost, this.onHandleOtherPostEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onHandleOtherPostEvent?.call({'action': 'navigateToDetailPost'});
          },
          child: Row(
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
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: _PostButton(
                icon: isLiked? Icon(Icons.thumb_up, color: Colors.blue, size: 20) : Icon(Icons.thumb_up_outlined, color: Colors.grey[600], size: 20),
                label: 'Thích',
                onTap: (){
                  onLikePost();
                },
              ),
            ),
            Expanded(
              child: _PostButton(
                icon: Icon(MdiIcons.commentOutline, color: Colors.grey[600], size: 20),
                label: 'Bình luận',
                onTap: (){
                  onHandleOtherPostEvent?.call({'action': 'navigateToDetailPost'});
                },
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

class PostVideoContainer extends StatefulWidget {
  final String url;
  PostVideoContainer({Key? key, required this.url}) : super(key: key);

  @override
  State<PostVideoContainer> createState() => _PostVideoContainerState();
}

class _PostVideoContainerState extends State<PostVideoContainer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: (YoutubePlayer.convertUrlToId(widget.url)!),
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: true,
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: YoutubePlayer(controller: _controller)
      ),
    );
  }
}


