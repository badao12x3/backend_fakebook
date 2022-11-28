import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:fakebook_frontend/constants/Palette.dart';
import 'package:fakebook_frontend/constants/localdata/LocalData.dart';
import 'package:fakebook_frontend/models/Models.dart';
import 'package:fakebook_frontend/screens/home/widgets/HomeWidgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.pink, // Navigation bar
              statusBarColor: Colors.lightBlue, // Status bar
            ),
            backgroundColor: Colors.white,
            title: Text(
              'facebook',
              style: const TextStyle(color: Palette.facebookBlue, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1),
            ),
            centerTitle: false,
            floating: true,
            actions: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
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
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle
                ),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(MdiIcons.facebookMessenger),
                  iconSize: 30,
                  color: Colors.black,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
              child: CreatePostContainer(currentUser: currentUser)
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
            sliver: SliverToBoxAdapter(
              child: OnlineUsers(onlineUsers: onlineUsers)
            ),
          ), 
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index){
                  final Post post = posts[index];
                  return PostContainer(post: post);
            },
              childCount: posts.length)
          )
        ],
      );
  }
}
