import 'package:equatable/equatable.dart';
import 'package:fakebook_frontend/models/models.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {}

class PostReload extends PostEvent {}

class PostLike extends PostEvent {
  final Post post;
  PostLike({required this.post});
}