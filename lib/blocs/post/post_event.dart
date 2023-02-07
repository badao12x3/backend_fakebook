import 'package:equatable/equatable.dart';
import 'package:fakebook_frontend/models/models.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {}

class PostReload extends PostEvent {}

class LikePost extends PostEvent {
  final Post post;
  LikePost({required this.post});
}