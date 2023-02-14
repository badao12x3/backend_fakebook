import 'package:equatable/equatable.dart';

import '../../models/list_friend_model.dart';

class FriendState extends Equatable {
  final ListFriend listFriendState;

  FriendState(
      {
        required this.listFriendState
      }
      );

  FriendState.initial()
      : listFriendState = ListFriend.initial();

  FriendState copyWith({
    ListFriend? listFriend,
  }) {
    return FriendState(
      listFriendState: listFriendState,
    );
  }

  @override
  String toString() {
    return 'RequestReceivedFriendState{RequestReceivedFriendList: $listFriendState}';
  }

  @override
  List<Object> get props => [listFriendState];
}
