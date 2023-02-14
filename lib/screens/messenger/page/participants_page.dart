import 'package:fakebook_frontend/screens/messenger/api/stream_user_api.dart';
import 'package:fakebook_frontend/screens/messenger/page/create_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../models/user_chat_model.dart';
import '../widgets/profile_image_widget.dart';

class ParticipantsPage extends StatefulWidget{

  const ParticipantsPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ParticipantsPageState();
  }

}

class _ParticipantsPageState extends State<ParticipantsPage> {
  late Future<List<UserChat>> allUser;

  List<UserChat> selectedUsers = [];
  @override
  void initState() {
    super.initState();

    allUser = StreamUserApi.getAllUser(includeMe: false, client: StreamChat.of(context).client);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text('Add Participants'),
          actions: [
            TextButton(
              child: Text('CREATE'),
              onPressed: (){}
              // selectedUsers.isEmpty
              //     ? null
              //     : () {
              //   Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) =>
              //         CreateRoomPage(participants: selectedUsers),
              //   ));
              // },
            ),
            const SizedBox(width: 8),
          ],
      ),
      body: FutureBuilder<List<UserChat>>(
        future: allUser,
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if(snapshot.hasError){
                return Center(child: Text('Đã xảy ra lỗi, Thử lại sau'));
              } else {
                final users = snapshot.data?.where((UserChat user) =>
                user.idUser != StreamChat.of(context).currentUser?.id)
                    .toList();

                return buildUsers(users!);
              }
          }
        },
      ),
    );
  }

  Widget buildUsers(List<UserChat> users) => ListView.builder(
    itemCount: users.length,
    itemBuilder: (context, index) {
      final user = users[index];

      return CheckboxListTile(
        value: selectedUsers.contains(user),
        onChanged: (isAdded) => setState(() =>
        isAdded! ? selectedUsers.add(user) : selectedUsers.remove(user)),
        title: Row(
          children: [
            ProfileImageWidget(imageUrl: user.imageUrl),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                user.name,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    },
  );

}