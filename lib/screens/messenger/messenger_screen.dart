import 'package:fakebook_frontend/screens/messenger/widgets/active_users_row_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../post/widgets/post_appbar.dart';

// class MessengerScreen extends StatefulWidget{
//
//
// }

class MessengerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MessengerScreenState();
  }
}

class _MessengerScreenState extends State<MessengerScreen> {
  late final Future<OwnUser> connectionFuture;
  late final client = StreamChat.of(context).client;
  late final name ;

  late final user = BlocProvider.of<AuthBloc>(context).state.authUser;
  // final token = user.token;
  // String userId ;
  // print("$token, $userId");
  @override
  void initState() {
    super.initState();
    // name = ModalRoute.of(context)?.settings.name;
    // print(ModalRoute.of(context)?.settings.name);
    final userId = user.id;
    connectionFuture = client.connectUser(
      User(id: userId),
      client.devToken(userId).rawValue
    );
  }

  @override
  void dispose() {
    print(ModalRoute.of(context)?.settings.name);
    client.disconnectUser();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: connectionFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const ChannelListPage();
              }
          }
        },
      ),
    );
  }
}

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  late final _listController = StreamChannelListController(
    client: StreamChat.of(context).client,
    filter: Filter.in_(
      'members',
      [StreamChat.of(context).currentUser!.id],
    ),
    sort: const [SortOption('last_message_at')],
    limit: 10,
  );

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StreamChannelListHeader(
        titleBuilder: (context, status, client) {
          return Text("Đoạn chat");
        },
        showConnectionStateTile: true,
        centerTitle: true,
        onNewChatButtonTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserListPage()) );
        },
      ),
      body: RefreshIndicator(
        onRefresh: _listController.refresh,
        child: StreamChannelListView(
          controller: _listController,
          onChannelTap: (channel) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return StreamChannel(
                    channel: channel,
                    child: const ChannelPage(),
                  );
                },
              ),
            );
          },
        ),
        // child: Column(
        //   children: [
        //     Container(
        //       height: 100,
        //       child: ActiveUsersRowWidget(),
        //     ),
        //     StreamChannelListView(
        //       controller: _listController,
        //       onChannelTap: (channel) {
        //         Navigator.of(context).push(
        //           MaterialPageRoute(
        //             builder: (context) {
        //               return StreamChannel(
        //                 channel: channel,
        //                 child: const ChannelPage(),
        //               );
        //             },
        //           ),
        //         );
        //       },
        //     ),
        //   ],
        // ),
      ),
    );
  }

}

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const StreamChannelHeader(),
      body: Column(
        children: const <Widget>[
          Expanded(
            child: StreamMessageListView(),
          ),
          StreamMessageInput(),
        ],
      ),
    );
  }
}