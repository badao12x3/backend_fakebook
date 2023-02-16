import 'package:fakebook_frontend/screens/messenger/page/participants_page.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../page/create_room_page.dart';

class ActiveUsersRowWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return buildCreateRoom(context);
  }

  Widget buildCreateRoom(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserListPage()),
      ),
      child: Container(
        width: 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: Icon(Icons.video_call, size: 28, color: Colors.black),
              radius: 25,
            ),
            Text(
              'Create\nRoom',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late final StreamUserListController _userListController =
  StreamUserListController(
    client: StreamChat.of(context).client,
    limit: 25,
    filter: Filter.and(
      [Filter.notEqual('id', StreamChat.of(context).currentUser!.id)],
    ),
    sort: [
      const SortOption(
        'name',
        direction: 1,
      ),
    ],
  );

  Set<User> _selectedUsers = {};
  void toggleSelectedListTile(User user) {
    if (_selectedUsers.contains(user))
      setState(() => _selectedUsers.remove(user));
    else
      setState(() => _selectedUsers.add(user));
  }

  @override
  void initState() {
    _userListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    _userListController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: Text('Add Participants', selectionColor: Colors.black,),
        actions: [
          TextButton(
            child: Text('CREATE'),
            onPressed: _selectedUsers.isEmpty
                ? null
                : () {
              _selectedUsers.add(StreamChat.of(context).currentUser!);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CreateRoomPage(participants: _selectedUsers),
              ));
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _userListController.refresh(),
        child: StreamUserListView(
          controller: _userListController,
          itemBuilder: (context, users, index, defaultWidget) {
            return defaultWidget.copyWith(
              selected: _selectedUsers.contains(users[index]),
            );
          },
          onUserTap: (user) {
            toggleSelectedListTile(user);
          },
        ),
      ),
    );
  }
}