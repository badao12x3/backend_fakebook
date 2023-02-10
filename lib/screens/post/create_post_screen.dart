import 'package:fakebook_frontend/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:fakebook_frontend/constants/localdata/local_data.dart';
import 'package:fakebook_frontend/screens/post/widgets/post_widgets.dart';


class CreatePostScreen extends StatefulWidget  {

  CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // In any case, when you are using a TextEditingController (or maintaining any mutable state), then you should use a StatefulWidget and keep the state in the State class.
  final TextEditingController textEditingController = TextEditingController();
  String? status;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PostAppbar(
        title: 'Tạo bài viết',
        action: 'Đăng',
        textEditingController: textEditingController,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).size.height * 0.2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PostInfo(avtUrl: currentUser.imageUrl, name: currentUser.name, status: status),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Đăng bài viết của bạn'),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
              child: DraggableScrollableSheet(
                initialChildSize: 0.3,
                maxChildSize: 0.3,
                minChildSize: 0.2,
                builder: (_, controller) {
                  return Material(
                    elevation: 20,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20)
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            width: 40,
                            color: Colors.grey[400],
                            height: 2,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: controller,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  return ListTile(
                                    onTap: () {},
                                    leading: Icon(Icons.photo_library, color: Colors.green),
                                    title: Text('Ảnh/video')
                                  );
                                case 1:
                                  return ListTile(
                                      onTap: () async {
                                        final statusGetBack = await Navigator.of(context).pushNamed(Routes.emotion_screen, arguments: status) as String?;
                                        // print("#Create_post_screen: $statusGetBack");
                                        setState(() {
                                          this.status = statusGetBack;
                                        });
                                        },
                                      leading: Icon(Icons.emoji_emotions_outlined, color: Colors.orange),
                                      title: Text('Cảm xúc')
                                  );
                                case 2:
                                  return ListTile(
                                      onTap: () {},
                                      leading: Icon(Icons.text_format, color: Colors.blue, size: 28),
                                      title: Text('Màu nền')
                                  );
                                default:
                                  return ListTile(
                                      onTap: () {},
                                      leading: Icon(Icons.photo_library, color: Colors.green),
                                      title: Text('Ảnh/video')
                                  );
                              }
                            }),
                        ),
                      ],
                    ),
                  );
                }
              )
          )
      ]),
    );
  }
}





