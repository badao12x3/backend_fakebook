import 'package:fakebook_frontend/screens/personal/widgets/friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fakebook_frontend/screens/personal/sub_screens/profile_settings_screen.dart';

import 'package:fakebook_frontend/screens/personal/widgets/personal_widgets.dart';
import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:fakebook_frontend/constants/localdata/local_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PersonalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            currentUser.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 250.0,
                  color: Colors.white,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => CoverBottomSheet());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 210.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              currentUser.imageUrl),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Positioned(top: 160, left: 360, child: CameraButton()),
                Positioned(
                    top: 80.0,
                    left: 20.0,
                    child: CircleAvatar(
                      radius: 85.0,
                      backgroundColor: Colors.white,
                      child: GestureDetector(
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
                    )),
                Positioned(top: 200, left: 135, child: CameraButton())
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentUser.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileSetScreen()));
                    },
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10.0)),
                      child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 45.0,
                          color: Colors.grey[300],
                          child: const Text(
                            "Cài đặt trang cá nhân",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          )),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  const Divider(height: 10.0, thickness: 2),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.cases_sharp),
                      const SizedBox(width: 10.0),
                      RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: "Sống và làm việc tại ",
                                style:
                                TextStyle(fontSize: 16.0, color: Colors.black)),
                            TextSpan(
                                text: "Hà Nội",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                          ]))
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Divider(height: 10.0, thickness: 2),
                  const SizedBox(height: 10.0),
                  Row(
                    children: const [
                      Expanded(
                          child: Text(
                            "Friends",
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          )),
                      Text(
                        "Find Friends",
                        style: TextStyle(
                            fontSize: 17.0, color: Palette.facebookBlue),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                  Text("69 friends",
                      style:
                      TextStyle(fontSize: 17.0, color: Colors.grey[700])),
                  // Friend(friendName: "Hoang", imageUrl: currentUser.imageUrl)
                  const SizedBox(
                    height: 10.0,
                  ),
                  // Container(
                  //   height: 800.0,
                  //   child: GridView.count(
                  //     crossAxisCount: 3,
                  //     children: List.generate(6, (index) {
                  //       return Friend(friendName: "Friend $index",
                  //           imageUrl: currentUser.imageUrl);
                  //     }),
                  //   ),
                  // )
                  Container(
                    height: 300.0,
                    child: GridView.builder(
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height/1.5)),
                      itemBuilder: (context, index) {
                        return GridTile(
                          child: Friend(
                            friendName: "Friend $index", imageUrl: currentUser.imageUrl,
                          ),
                          // child: index%2 == 0?Container(color: Colors.red):Container(color: Colors.blue,)
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
