import 'package:equatable/equatable.dart';

abstract class RequestReceivedFriendEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RequestReceivedFriendFetched extends RequestReceivedFriendEvent {}

class RequestReceivedFriendAccept extends RequestReceivedFriendEvent {
  final String fromUser;
  RequestReceivedFriendAccept({required this.fromUser});
}

class RequestReceivedFriendDelete extends RequestReceivedFriendEvent {
  final String fromUser;
  RequestReceivedFriendDelete({required this.fromUser});
}