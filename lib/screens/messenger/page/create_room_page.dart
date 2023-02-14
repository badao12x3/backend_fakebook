import 'dart:io';

import 'package:fakebook_frontend/models/user_chat_model.dart';
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

            final channel = await  StreamChat.of(context).client.channel(
              "messaging",
              id: "travel",
              extraData: {
                "name": name,
                "image": "http://bit.ly/2O35mws",
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
            final pickedFile =
            await ImagePicker().getImage(source: ImageSource.gallery);

            if (pickedFile == null) return;

            setState(() {
              imageFile = File(pickedFile.path);
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
      leading: ProfileImageWidget(imageUrl: member.image ?? "https://images.unsplash.com/photo-1580907114587-148483e7bd5f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80"),
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