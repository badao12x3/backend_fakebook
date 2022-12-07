import 'package:fakebook_frontend/constants/Palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String action;
  final TextEditingController textEditingController;

  const PostAppbar({Key? key, required this.title, required this.action, required this.textEditingController}) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  State<PostAppbar> createState() => _PostAppbarState();

}

class _PostAppbarState extends State<PostAppbar> {
  bool allowedToAct = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.textEditingController.addListener(
      () {
        setState(() {
          allowedToAct = widget.textEditingController.text.isNotEmpty;
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    print(allowedToAct);
    return AppBar(
      leading: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: IconButton(
          splashColor: Colors.transparent,
          // highlightColor: Colors.transparent,
          splashRadius: 20,
          icon: Icon(Icons.close),
          iconSize: 30,
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[100],
      elevation: 1,
      title: Align(
        child: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 20)),
        alignment: Alignment.center,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: ElevatedButton(
            style: allowedToAct ? ElevatedButton.styleFrom(
                backgroundColor: Palette.facebookBlue,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 20),
                splashFactory: NoSplash.splashFactory)
            :
            ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.grey[200],
                disabledForegroundColor: Colors.black38,
                textStyle: const TextStyle(fontSize: 20),
                splashFactory: NoSplash.splashFactory
            ),

            child: Text(
              widget.action,
              // style: const TextStyle(
              //   fontWeight: FontWeight.w400,
              //   color: Colors.grey,
              //   fontSize: 20
              // )
            ),
            onPressed: allowedToAct ? () {} : null,
          ),
        )
      ],
    );
  }
}
