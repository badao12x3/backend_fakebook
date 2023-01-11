import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:fakebook_frontend/constants/localdata/local_data.dart';
import 'package:fakebook_frontend/screens/post/widgets/post_widgets.dart';
import 'package:flutter/material.dart';


class CreatePostScreen extends StatefulWidget  {

  CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // In any case, when you are using a TextEditingController (or maintaining any mutable state), then you should use a StatefulWidget and keep the state in the State class.
  final TextEditingController textEditingController = TextEditingController();

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PostInfo(avtUrl: currentUser.imageUrl, name: currentUser.name),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration.collapsed(hintText: 'Đăng bài viết của bạn'),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                )
              ],

          ),
        ),
      ),
    );
  }
}





