import 'package:equatable/equatable.dart';

abstract class PersonalInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PersonalInfoFetched extends PersonalInfoEvent {}

class PersonalInfoOfAnotherUserFerched extends PersonalInfoEvent {
  final String id;
  PersonalInfoOfAnotherUserFerched({required this.id});
}
