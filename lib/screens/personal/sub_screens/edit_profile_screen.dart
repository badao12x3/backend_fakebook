import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakebook_frontend/constants/localdata/local_data.dart';
import 'package:flutter/material.dart';

import 'package:fakebook_frontend/screens/personal/widgets/personal_widgets.dart';
import 'package:fakebook_frontend/constants/assets/palette.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Chỉnh sửa trang cá nhân',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Ảnh đại diện",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    )),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => AvatarBottomSheet());
                      },
                      child: Text(
                        "Chỉnh sửa",
                        style: TextStyle(
                            fontSize: 17.0, color: Palette.facebookBlue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => AvatarBottomSheet());
                  },
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundImage:
                        CachedNetworkImageProvider(currentUser.imageUrl),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Divider(
                  height: 0.0,
                  thickness: 1.0,
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Ảnh bìa",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    )),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => CoverBottomSheet());
                      },
                      child: Text(
                        "Chỉnh sửa",
                        style: TextStyle(
                            fontSize: 17.0, color: Palette.facebookBlue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => CoverBottomSheet());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 220.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image:
                              CachedNetworkImageProvider(currentUser.imageUrl),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Divider(
                  height: 0.0,
                  thickness: 1.0,
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
