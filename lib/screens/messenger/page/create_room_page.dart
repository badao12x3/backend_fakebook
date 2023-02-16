import 'dart:io';

import 'package:fakebook_frontend/models/user_chat_model.dart';
import 'package:fakebook_frontend/screens/messenger/api/firebase_google_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../messenger_screen.dart';
import '../widgets/profile_image_widget.dart';

class CreateRoomPage extends StatefulWidget {
  final Set<User> participants;

  const CreateRoomPage({
    Key? key,
    required this.participants,
  }) : super(key: key);

  @override
  _CreateRoomPageState createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  String name = '';
  var imageFile;


  @override
  void initState() {
    super.initState();
    // imageFile = File("");
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Create Room'),
      actions: [
        IconButton(
          icon: Icon(Icons.done),
          onPressed: () async {
            final idParticipants = widget.participants
                .map((participant) => participant.id)
                .toList();

            final idChanel = Uuid().v4();
            // final urlImage = await FirebaseGoogleApi.uploadImage("image/$idChanel", imageFile);
            final channel = await  StreamChat.of(context).client.channel(
              "messaging",
              id: idChanel,
              extraData: {
                "name": name,
                "image": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepik.com%2Fpremium-vector%2Fgroup-people-holding-blank-sign-banner-character-flat-cartoon-illustration-vector-design_20075961.htm&psig=AOvVaw2GgSVs9jxDl53waVyEsWTu&ust=1676584986696000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCNDY2vfDmP0CFQAAAAAdAAAAABAE",
                "members": idParticipants,
              },
            );
            channel.watch();

            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
            // Navigator.of(context).
            // pushAndRemoveUntil(
            //   MaterialPageRoute(builder: (context) => MessengerScreen()),
            //   ModalRoute.withName('/messenger_screen'),
            // );
          },
        ),
        const SizedBox(width: 8),
      ],
    ),
    body: ListView(
      padding: EdgeInsets.all(24),
      children: [
        GestureDetector(
          onTap: 
              () async {
            // var picked = await FilePicker.platform.pickFiles();
            //
            // if (picked != null) {
            //   print(picked.files.first.name);
            //
            // }else return;

            final pickedFile =
            await ImagePicker().getImage(source: ImageSource.gallery);

            if (pickedFile == null) return;

            setState(() {
              imageFile = File(pickedFile.path);

              // imageFile = File(picked.files.first.path!);
            });
          },
          child: buildImage(context),
        ),
        const SizedBox(height: 48),
        buildTextField(),
        const SizedBox(height: 12),
        Text(
          'Participants',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 12),
        buildMembers(),
      ],
    ),
  );

  Widget buildImage(BuildContext context) {
    if (imageFile == null) {
      return CircleAvatar(
        radius: 64,
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.add, color: Colors.white, size: 64),
      );
    } else {
      return CircleAvatar(
        radius: 64,
        backgroundColor: Theme.of(context).accentColor,
        child: ClipOval(
          child:
          Image.file(imageFile, fit: BoxFit.cover, width: 128, height: 128),
        ),
      );
    }
  }

  Widget buildTextField() => TextFormField(
    decoration: InputDecoration(
      labelText: 'Channel Name',
      labelStyle: TextStyle(color: Colors.black),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(),
    ),
    maxLength: 30,
    onChanged: (value) => setState(() => name = value),
  );

  Widget buildMembers() => Column(
    children: widget.participants
        .map((member) => ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ProfileImageWidget(imageUrl: member.image ?? "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fvectors%2Fblank-profile-picture-mystery-man-973460%2F&psig=AOvVaw35UMz_aHbEjd-jPZW4Lx99&ust=1676570463404000&source=images&cd=vfe&ved=0CA0QjRxqFwoTCLiVjOuNmP0CFQAAAAAdAAAAABAD"),
      title: Text(
        member.name,
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ))
        .toList(),
  );
}