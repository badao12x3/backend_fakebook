import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constants/Palette.dart';
import '../../constants/localdata/PostData.dart';
import '../../constants/localdata/VideoData.dart';
import '../../models/PostModel.dart';
import '../../models/VideoModel.dart';
import '../home/widgets/PostContainer.dart';

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

        // SliverPadding(
        //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        //   sliver: SliverToBoxAdapter(
        //       child: Container(
        //           height: 58, // mong muốn không fix cứng
        //           color: Colors.white,
        //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        //           child: Material(
        //               color: Colors.transparent,
        //               child: ListView.builder(
        //                   scrollDirection: Axis.horizontal,
        //                   itemCount: 1,
        //                   itemBuilder: (BuildContext context, int index){
        //                     return Padding(
        //                       padding: EdgeInsets.symmetric(horizontal: 0),
        //                         child: WatchFilterSection()
        //                     );
        //                   }
        //               )
        //           )
        //       )
        //   ),
        // ),
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
                          children: [
                            _PostHeader(avtUrl: post.user.imageUrl, name: post.user.name, timeAgo: post.createdTime.toString()),
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

    // return SingleChildScrollView(
    //   child: SingleChildScrollView(
    //     child: Container(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Padding(
    //               padding: const EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
    //               child: Text('Watch', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
    //             ),
    //
    //             Container(
    //               height: 60.0,
    //               padding: EdgeInsets.symmetric(vertical: 10.0),
    //               child: ListView(
    //                 scrollDirection: Axis.horizontal,
    //                 children: <Widget>[
    //                   SizedBox(width: 15.0),
    //                   Container(
    //                     padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
    //                     decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(40.0),
    //                         color: Colors.grey[300]
    //                     ),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: <Widget>[
    //                         Icon(Icons.videocam, size: 20.0),
    //                         SizedBox(width: 5.0),
    //                         Text('Live', style: TextStyle(fontWeight: FontWeight.bold))
    //                       ],
    //                     ),
    //                   ),
    //
    //                   SizedBox(width: 10.0),
    //
    //                   Container(
    //                     padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
    //                     decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(40.0),
    //                         color: Colors.grey[300]
    //                     ),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: <Widget>[
    //                         Icon(Icons.music_note, size: 20.0),
    //                         SizedBox(width: 5.0),
    //                         Text('Music', style: TextStyle(fontWeight: FontWeight.bold))
    //                       ],
    //                     ),
    //                   ),
    //
    //                   SizedBox(width: 10.0),
    //
    //                   Container(
    //                     padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
    //                     decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(40.0),
    //                         color: Colors.grey[300]
    //                     ),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: <Widget>[
    //                         Icon(Icons.check_box, size: 20.0),
    //                         SizedBox(width: 5.0),
    //                         Text('Following', style: TextStyle(fontWeight: FontWeight.bold))
    //                       ],
    //                     ),
    //                   ),
    //
    //                   SizedBox(width: 10.0),
    //
    //                   Container(
    //                     padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
    //                     decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(40.0),
    //                         color: Colors.grey[300]
    //                     ),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: <Widget>[
    //                         Icon(Icons.fastfood, size: 20.0),
    //                         SizedBox(width: 5.0),
    //                         Text('Food', style: TextStyle(fontWeight: FontWeight.bold))
    //                       ],
    //                     ),
    //                   ),
    //
    //                   SizedBox(width: 10.0),
    //
    //                   Container(
    //                     padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
    //                     decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(40.0),
    //                         color: Colors.grey[300]
    //                     ),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: <Widget>[
    //                         Icon(Icons.gamepad, size: 20.0),
    //                         SizedBox(width: 5.0),
    //                         Text('Gaming', style: TextStyle(fontWeight: FontWeight.bold))
    //                       ],
    //                     ),
    //                   ),
    //
    //                   SizedBox(width: 15.0),
    //                 ],
    //               ),
    //             ),
    //
    //             SeparatorWidget(),
    //
    //             Column(
    //               children: <Widget>[
    //                 Padding(
    //                   padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
    //                   child: Row(
    //                     children: <Widget>[
    //                       CircleAvatar(
    //                         backgroundImage: AssetImage('assets/greg.jpg'),
    //                         radius: 20.0,
    //                       ),
    //                       SizedBox(width: 7.0),
    //                       Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: <Widget>[
    //                           Text('Greg', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
    //                           SizedBox(height: 5.0),
    //                           Text('7h')
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //
    //                 SizedBox(height: 20.0),
    //
    //                 YoutubePlayer(controller: _controller1),
    //
    //                 SizedBox(height: 10.0),
    //
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: <Widget>[
    //                       Row(
    //                         children: <Widget>[
    //                           Icon(FontAwesomeIcons.thumbsUp, size: 15.0, color: Colors.blue),
    //                           Text(' 23'),
    //                         ],
    //                       ),
    //                       Row(
    //                         children: <Widget>[
    //                           Text('2 comments  •  '),
    //                           Text('1 share'),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
    //                   child: Divider(height: 30.0),
    //                 ),
    //
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: <Widget>[
    //                       Row(
    //                         children: <Widget>[
    //                           Icon(FontAwesomeIcons.thumbsUp, size: 20.0),
    //                           SizedBox(width: 5.0),
    //                           Text('Like', style: TextStyle(fontSize: 14.0)),
    //                         ],
    //                       ),
    //                       Row(
    //                         children: <Widget>[
    //                           Icon(FontAwesomeIcons.commentAlt, size: 20.0),
    //                           SizedBox(width: 5.0),
    //                           Text('Comment', style: TextStyle(fontSize: 14.0)),
    //                         ],
    //                       ),
    //                       Row(
    //                         children: <Widget>[
    //                           Icon(FontAwesomeIcons.share, size: 20.0),
    //                           SizedBox(width: 5.0),
    //                           Text('Share', style: TextStyle(fontSize: 14.0)),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //
    //             SizedBox(height: 20.0),
    //
    //             SeparatorWidget(),
    //
    //             Column(
    //               children: <Widget>[
    //                 Padding(
    //                   padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
    //                   child: Row(
    //                     children: <Widget>[
    //                       CircleAvatar(
    //                         backgroundImage: AssetImage('assets/olivia.jpg'),
    //                         radius: 20.0,
    //                       ),
    //                       SizedBox(width: 7.0),
    //                       Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: <Widget>[
    //                           Text('Olivia', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
    //                           SizedBox(height: 5.0),
    //                           Text('10h')
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //
    //                 SizedBox(height: 20.0),
    //
    //                 YoutubePlayer(controller: _controller2),
    //
    //                 SizedBox(height: 10.0),
    //
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: <Widget>[
    //                       Row(
    //                         children: <Widget>[
    //                           Icon(FontAwesomeIcons.thumbsUp, size: 15.0, color: Colors.blue),
    //                           Text(' 98'),
    //                         ],
    //                       ),
    //                       Row(
    //                         children: <Widget>[
    //                           Text('12 comments  •  '),
    //                           Text('6 shares'),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
    //                   child: Divider(height: 30.0),
    //                 ),
    //
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: <Widget>[
    //                       Row(
    //                         children: <Widget>[
    //                           Icon(FontAwesomeIcons.thumbsUp, size: 20.0),
    //                           SizedBox(width: 5.0),
    //                           Text('Like', style: TextStyle(fontSize: 14.0)),
    //                         ],
    //                       ),
    //                       Row(
    //                         children: <Widget>[
    //                           Icon(FontAwesomeIcons.commentAlt, size: 20.0),
    //                           SizedBox(width: 5.0),
    //                           Text('Comment', style: TextStyle(fontSize: 14.0)),
    //                         ],
    //                       ),
    //                       Row(
    //                         children: <Widget>[
    //                           Icon(FontAwesomeIcons.share, size: 20.0),
    //                           SizedBox(width: 5.0),
    //                           Text('Share', style: TextStyle(fontSize: 14.0)),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //
    //             SizedBox(height: 20.0),
    //
    //             SeparatorWidget(),
    //           ],
    //         )
    //     ),
    //   ),
    // );
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
    _controller = YoutubePlayerController(initialVideoId: (YoutubePlayer.convertUrlToId(widget.url)!));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children:<Widget>[
        Container(
          // height: 236,
          // width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child:  YoutubePlayer(controller: _controller)
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
    return  Container(
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
                  Text('$timeAgo ∙', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
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

