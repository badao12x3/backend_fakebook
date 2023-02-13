import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/comment_repository.dart';
import 'package:fakebook_frontend/blocs/comment/comment_event.dart';
import 'package:fakebook_frontend/blocs/comment/comment_state.dart';
import 'package:fakebook_frontend/models/comment_model.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  late final CommentRepository commentRepository;

  CommentBloc(): super(CommentState.initial()) {
    commentRepository = CommentRepository();

    on<CommentFetched>(_onCommentFetched);
  }

  Future<void> _onCommentFetched(CommentFetched event, Emitter<CommentState> emit) async {
    try {
      final postId = event.postId;
      emit(state.copyWith(commentStatus: CommentStatus.loading));
      final List<Comment>? comments = await commentRepository.fetchComments(postId: postId);
      if (comments != null) {
        emit(CommentState(commentStatus: CommentStatus.success, comments: comments));
      }
    } catch(error) {
      emit(state.copyWith(commentStatus: CommentStatus.failure));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print('#COMMENT OBSERVER: $error');
  }

  @override
  void onTransition(Transition<CommentEvent, CommentState> transition) {
    super.onTransition(transition);
    // print('#COMMENT OBSERVER: $transition');
  }

  @override
  void onEvent(CommentEvent event) {
    super.onEvent(event);
    print('#COMMENT OBSERVER: $event');
  }

  @override
  void onChange(Change<CommentState> change) {
    super.onChange(change);
    print('#COMMENT OBSERVER: { stateCurrent: ${change.currentState.comments?.length ?? 0}, statusCurrent: ${change.currentState.commentStatus} }');
    print('#COMMENT OBSERVER: { stateNext: ${change.nextState.comments?.length ?? 0}, statusNext: ${change.nextState.commentStatus} }');
  }
}