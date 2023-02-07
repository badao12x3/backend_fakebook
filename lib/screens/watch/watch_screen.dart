import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constants/assets/palette.dart';
import '../../constants/localdata/video_data.dart';
import '../../models/local/video_model.dart';

class WatchTab extends StatefulWidget {
  @override
  _WatchTabState createState() => _WatchTabState();
}

class _WatchTabState extends State<WatchTab> {
  Color backgroundColor = Colors.white;

  changeBackgroundColor() {
    setState(() {
      backgroundColor = Colors.black;
    });
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // Navigation bar
            statusBarColor: Colors.lightBlue, // Status bar
          ),
          floating: true,
          automaticallyImplyLeading: false,
          // pinned: true,
          title: Text(
              'Watch',
              style: TextStyle(color: Colors.black, fontSize: 28.0, fontWeight: FontWeight.bold)
          ),
          actions: [
            Container(
              height: 42.0,
              width: 42.0,
              margin: EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,

              ),
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(Icons.person),
                iconSize: 28,
                color: Colors.black,
                onPressed: () {},
              ),
            ),
            Container(
              height: 42.0,
              width: 42.0,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle
              ),
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(Icons.search),
                iconSize: 30,
                color: Colors.black,
                onPressed: () {},
              ),
            )
          ],
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(47.0),
            child: Transform.translate(
                offset: const Offset(6, 0),
                child: Container(
                  height: 50,
                  color: Colors.white,
                  child: Material(
                    color: Colors.transparent,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index){
                          return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: WatchFilterSection(changeBackgroundColor: changeBackgroundColor)
                          );
                        }
                    ),
                  ),
                )

            ),
          ),
        ),

        SliverList(
            delegate: SliverChildBuilderDelegate((context, index){
              final Video post = videos[index];
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
                            _PostHeader(avtUrl: post.user.imageUrl, name: post.user.name, timeAgo: post.createdTime.toString()),
                            const SizedBox(height: 4),
                            Text(post.described)
                          ]
                      ),
                    ),
                    VideoContainer(url: post.videoUrl),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _PostStats(likes: post.likes),
                    )
                  ],
                ),
              );
            },
            childCount: videos.length)
        )
      ],
    );

  }
}

class VideoContainer extends StatefulWidget {
  final String url;
  const VideoContainer({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoContainer> createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
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
    return Stack(
      children:<Widget>[
        Container(
          // height: 236,
          // width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: YoutubePlayer(controller: _controller)
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(Icons.airplay_sharp),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: IconButton(
            icon: const Icon(Icons.volume_up_outlined),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}


class WatchFilterSection extends StatelessWidget {
  final Function changeBackgroundColor;
  WatchFilterSection({Key? key, required this.changeBackgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: [
            WatchSection(title: 'Trực tiếp',icons: Icons.video_camera_front, changeBackgroundColor: changeBackgroundColor),
            WatchSection(title: 'Ẩm thực',icons: Icons.umbrella, changeBackgroundColor: changeBackgroundColor),
            WatchSection(title: 'Chơi game',icons: Icons.gas_meter, changeBackgroundColor: changeBackgroundColor),
            WatchSection(title: 'Đang theo dõi',icons: Icons.gas_meter, changeBackgroundColor: changeBackgroundColor),
            WatchSection(title: 'Reels',icons: Icons.gas_meter, changeBackgroundColor: changeBackgroundColor),
          ],
        ),
    );
  }
}

class WatchSection extends StatelessWidget {
  final String title;
  final IconData icons;
  final Function changeBackgroundColor;
  WatchSection({Key? key, required this.title, required this.icons, required this.changeBackgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      child: ElevatedButton.icon(
        label: Text(title),
        icon: Icon(icons),
        onPressed: () => {
          changeBackgroundColor()
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80),
          ),
        ),
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
  const _PostStats({Key? key, required this.likes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Palette.facebookBlue,
                  shape: BoxShape.circle
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                '${likes}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
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

