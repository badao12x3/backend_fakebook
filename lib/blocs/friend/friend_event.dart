import 'package:equatable/equatable.dart';

abstract class FriendEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FriendFetched extends FriendEvent {}

class FriendOfAnotherUserFetched extends FriendEvent {
  final String id;
  FriendOfAnotherUserFetched({required this.id});
}

