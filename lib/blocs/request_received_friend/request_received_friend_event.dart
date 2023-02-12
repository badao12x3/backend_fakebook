import 'package:equatable/equatable.dart';

abstract class RequestReceivedFriendEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RequestReceivedFriendFetched extends RequestReceivedFriendEvent {}
