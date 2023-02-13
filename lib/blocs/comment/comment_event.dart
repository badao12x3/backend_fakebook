import 'package:equatable/equatable.dart';

import 'package:fakebook_frontend/models/comment_model.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CommentFetched extends CommentEvent {
  final String postId;

  CommentFetched({required this.postId});
}

class CommentSet extends CommentEvent {
  final String postId;
  final Comment comment;

  CommentSet({required this.postId, required this.comment});
}

