import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakebook_frontend/blocs/post_detail/post_detail_bloc.dart';
import 'package:fakebook_frontend/blocs/post_detail/post_detail_event.dart';
import 'package:fakebook_frontend/blocs/post_detail/post_detail_state.dart';
import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constants/assets/placeholder.dart';
import '../../repositories/post_repository.dart';

class PostDetailScreen extends StatelessWidget {
  final String postId;
  const PostDetailScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // null. Hơi lạ
    // final String postId = ModalRoute.of(context)?.settings.arguments as String;
    print("#PostDetailScreen: " + postId);
    BlocProvider.of<PostDetailBloc>(context).add(PostDetailFetched(postId: postId));
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: PostDetailContent(),
          ),
        )

      // child: PostDetailContent(),
    );
  }
}

class PostDetailContent extends StatelessWidget {
  const PostDetailContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostDetailBloc, PostDetailState>(
        builder: (context, state) {
          switch (state.postDetailStatus) {
            case PostDetailStatus.initial:
              return Center(child: CircularProgressIndicator());
            case PostDetailStatus.loading:
              return Center(child: CircularProgressIndicator());
            case PostDetailStatus.failure:
              return Center(child: Text('Failed to fetch posts'));
            case PostDetailStatus.success: {
              final post = state.postDetail!;
              DateTime dt1 = DateTime.now();
              DateTime dt2 = DateTime.parse(post.updatedAt);
              final Duration diff = dt1.difference(dt2);
              final String timeAgo = diff.inDays == 0 ? "${diff.inHours}h" : "${diff.inDays}d";
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
                            _PostDetailHeader(avtUrl: post.author.avatar, name: post.author.name, timeAgo: timeAgo),
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
                      child: PostDetailVideoContainer(url: post.video?.url ?? VideoPlaceHolder.videoPlaceHolderOnline),
                    ) : const SizedBox.shrink(),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _PostDetailStats(
                          likes: post.likes,
                          comments: post.comments,
                          shares: 0,
                          isLiked: post.isLiked,
                          onLikePost: () {

                          }
                      ),
                    )
                  ],
                ),
              );
            }

          }
        }
    );
  }
}

class _PostDetailHeader extends StatelessWidget {
  final String avtUrl;
  final String name;
  final String timeAgo;
  const _PostDetailHeader({Key? key, required this.avtUrl, required this.name, required this.timeAgo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
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

class _PostDetailStats extends StatelessWidget {
  final int likes;
  final int comments;
  final int shares;
  final bool isLiked;
  final Function() onLikePost;

  const _PostDetailStats({Key? key, required this.likes, required this.comments, required this.shares, required this.isLiked, required this.onLikePost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  color: Palette.facebookBlue, shape: BoxShape.circle),
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
              child: _PostDetailButton(
                icon: isLiked? Icon(Icons.thumb_up, color: Colors.blue, size: 20) : Icon(Icons.thumb_up_outlined, color: Colors.grey[600], size: 20),
                label: 'Thích',
                onTap: (){
                  onLikePost();
                },
              ),
            ),
            Expanded(
              child: _PostDetailButton(
                icon: Icon(MdiIcons.commentOutline, color: Colors.grey[600], size: 20),
                label: 'Bình luận',
                onTap: (){},
              ),
            ),
            Expanded(
              child: _PostDetailButton(
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

class _PostDetailButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback onTap;
  const _PostDetailButton({Key? key, required this.icon, required this.label, required this.onTap}) : super(key: key);

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

class PostDetailVideoContainer extends StatefulWidget {
  final String url;
  PostDetailVideoContainer({Key? key, required this.url}) : super(key: key);

  @override
  State<PostDetailVideoContainer> createState() => _PostDetailVideoContainerState();
}

class _PostDetailVideoContainerState extends State<PostDetailVideoContainer> {
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


