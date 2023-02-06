import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {}

class PostReload extends PostEvent {}

class LikePost extends PostEvent {}