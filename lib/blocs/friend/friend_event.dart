import 'package:equatable/equatable.dart';

import '../../models/list_friend_model.dart';

abstract class FriendEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FriendFetched extends FriendEvent {}

class FriendOfAnotherUserFetched extends FriendEvent {
  final String id;
  FriendOfAnotherUserFetched({required this.id});
}

class FriendDelete extends FriendEvent {
  final Friend friend;
  FriendDelete({required this.friend});
}
