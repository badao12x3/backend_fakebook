import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:fakebook_frontend/screens/friend/widgets/friend_widgets.dart';

import '../../blocs/request_received_friend/request_received_friend_bloc.dart';
import '../../blocs/request_received_friend/request_received_friend_event.dart';
import '../../blocs/request_received_friend/request_received_friend_state.dart';
import '../../common/widgets/bottom_loader.dart';
import '../../models/request_received_friend_model.dart';
import '../../models/request_received_friend_model.dart';

class FriendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RequestReceivedFriendBloc>(context)
        .add(RequestReceivedFriendFetched());
    return SafeArea(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Bạn bè",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(MdiIcons.magnify))
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                              child: OutlinedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey.shade300),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0)))),
                                onPressed: () {},
                                child: Text('Gợi ý'),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                              child: OutlinedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey.shade300),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0)))),
                                onPressed: () {},
                                child: Text('Tất cả bạn bè'),
                              ))
                        ],
                      )),
                  Divider(),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Lời mời kết bạn  ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          NumberOfFriendRequests(),
                        ],
                      )),
                  Divider(),

                  FriendRequestList()

                  // Padding(
                  //     padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  //     child: RequestContainer(name: "Đào Minh Tiến",
                  //         avtUrl: "https://scontent-hkg4-2.xx.fbcdn.net/v/t39.30808-1/288572692_1475287869570589_4828695694083833263_n.jpg?stp=dst-jpg_p100x100&_nc_cat=111&ccb=1-7&_nc_sid=7206a8&_nc_ohc=DnOy_7i0nZ0AX_SAbOi&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent-hkg4-2.xx&oh=00_AfCSdjTUAxZFBpzzE4aNwgFFDMrP4_-27YZ-3-1_cobCuQ&oe=639BBD18",
                  //         timeAgo: "2 giờ")
                  // ),
                ],
              ),
            )));
  }
}

class NumberOfFriendRequests extends StatelessWidget {
  const NumberOfFriendRequests({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestReceivedFriendBloc, RequestReceivedFriendState>(
        builder: (context, state) {
      final friendRequestReceivedList = state.friendRequestReceivedList;
      return Text(
          friendRequestReceivedList
              .toJson()["RequestReceivedFriend"]
              .length
              .toString(),
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red));
    });
  }
}

class FriendRequests extends StatelessWidget {
  final RequestReceivedFriend requestReceivedFriend;
  const FriendRequests({Key? key, required this.requestReceivedFriend})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("test 1")]),
          ),
        ],
      ),
    );
  }
}

class FriendRequest extends State<FriendRequestList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestReceivedFriendBloc, RequestReceivedFriendState>(
        builder: (context, state) {
      final friendRequestReceivedList = state.friendRequestReceivedList;

      return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return index >=
                friendRequestReceivedList
                    .toJson()["RequestReceivedFriend"]
                    .length
            ? const BottomLoader()
            : FriendRequests(
                requestReceivedFriend:
                    friendRequestReceivedList.toJson()["RequestReceivedFriend"]
                        [index] as RequestReceivedFriend);
      },
              childCount: friendRequestReceivedList
                  .toJson()["RequestReceivedFriend"]
                  .length));
    });
  }
}

class FriendRequestList extends StatefulWidget {
  const FriendRequestList({
    Key? key,
  }) : super(key: key);

  @override
  State<FriendRequestList> createState() => FriendRequest();
}
