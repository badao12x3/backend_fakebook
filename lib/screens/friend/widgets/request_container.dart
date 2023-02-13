import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/request_received_friend/request_received_friend_bloc.dart';
import '../../../blocs/request_received_friend/request_received_friend_event.dart';

class RequestContainer extends StatelessWidget {
  final String fromUser;
  final String name;
  final String avtUrl;
  final String timeAgo;
  const RequestContainer(
      {Key? key,
      required this.fromUser,
      required this.name,
      required this.avtUrl,
      required this.timeAgo})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      height: 100,
      // child: IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: CachedNetworkImageProvider(avtUrl),
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                        flex: 5,
                        child: Text(name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                    Flexible(
                        flex: 2,
                        child: Text(timeAgo,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                fontSize: 13, color: Palette.grey1)))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 6, 2),
                          child: OutlinedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Palette.facebookBlue)),
                            onPressed: () {
                              acceptConfirmation(context);
                            },
                            child: Text('Chấp nhận',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ))),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(6, 0, 0, 2),
                          child: OutlinedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey.shade200)),
                            onPressed: () {
                              rejectConfirmation(context);
                            },
                            child: Text('Xóa'),
                          ))),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  // void acceptConfirmation(BuildContext context)
  // {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context)
  //       {
  //         return Container(
  //             color: Colors.white,
  //             height: 150,
  //             child: Center(
  //                 child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(vertical: 12),
  //                         child: Text("Chấp nhận lời mời kết bạn?",
  //                                     style: TextStyle(fontSize: 20)),
  //                       ),
  //                       Divider(),
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 12),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           crossAxisAlignment: CrossAxisAlignment.end,
  //                           children: [
  //                             Expanded(child: Padding(
  //                                 padding: const EdgeInsets.fromLTRB(0, 0, 6, 2),
  //                                 child: OutlinedButton(
  //                                   style: ButtonStyle(
  //                                       foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  //                                       backgroundColor: MaterialStateProperty.all<Color>(Palette.facebookBlue)
  //                                   ),
  //                                   onPressed: () {
  //                                     //TODO: Xử lý sau
  //                                     Navigator.pop(context);
  //                                   },
  //                                   child: Text('Xác nhận',
  //                                       style: TextStyle(fontWeight: FontWeight.bold)),
  //                                 ))),
  //
  //                             Expanded(child: Padding(
  //                                 padding: const EdgeInsets.fromLTRB(6, 0, 0, 2),
  //                                 child: OutlinedButton(
  //                                   style: ButtonStyle(
  //                                       foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
  //                                       backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200)
  //                                   ),
  //                                   onPressed: () {
  //                                     //TODO: Xử lý sau
  //                                     Navigator.pop(context);
  //                                   },
  //                                   child: Text('Hủy'),
  //                                 ))),
  //                           ],
  //                         ),
  //                       )
  //                     ]
  //                 )));
  //       }
  //   );
  // }

  void acceptConfirmation(BuildContext context) {
    void handleRequestReceivedFriendAccept() {
      BlocProvider.of<RequestReceivedFriendBloc>(context).add(RequestReceivedFriendAccept(fromUser: fromUser));
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Chấp nhận lời mời kết bạn?'),
            actions: [
              OutlinedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Palette.facebookBlue)),
                onPressed: () {
                  //TODO: Xử lý sau
                  Navigator.pop(context);
                  handleRequestReceivedFriendAccept();

                },
                child: Text('Xác nhận',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              OutlinedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey.shade200)),
                onPressed: () {
                  //TODO: Xử lý sau
                  Navigator.pop(context);
                },
                child: Text('Hủy'),
              )
            ],
          );
        });
  }

  void rejectConfirmation(BuildContext context) {
    void handleRequestReceivedFriendDelete() {
      BlocProvider.of<RequestReceivedFriendBloc>(context).add(RequestReceivedFriendDelete(fromUser: fromUser));
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Xóa lời mời kết bạn?'),
            actions: [
              OutlinedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey.shade200)),
                onPressed: () {
                  Navigator.pop(context);
                  handleRequestReceivedFriendDelete();
                },
                child: Text('Xác nhận',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              OutlinedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey.shade200)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Hủy'),
              )
            ],
          );
        });
  }
}
