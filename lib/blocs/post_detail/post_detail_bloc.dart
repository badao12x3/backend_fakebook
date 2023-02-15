import 'package:fakebook_frontend/blocs/post_detail/post_detail_event.dart';
import 'package:fakebook_frontend/blocs/post_detail/post_detail_state.dart';
import 'package:fakebook_frontend/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  late final PostRepository postRepository;
  PostDetailBloc({required this.postRepository}): super(PostDetailState.initial()) {
    on<PostDetailFetched>(_onPostDetailFetched);
  }

  Future<void> _onPostDetailFetched(PostDetailFetched event, Emitter<PostDetailState> emit) async {
    try {
      final postId = event.postId;
      emit(PostDetailState(postDetailStatus: PostDetailStatus.loading));
      final postDetail = await postRepository.fetchDetailPost(postId: postId);
      if (postDetail != null) {
        emit(PostDetailState(postDetailStatus: PostDetailStatus.success, postDetail: postDetail));
      }

    } catch(error) {
      emit(PostDetailState(postDetailStatus: PostDetailStatus.failure, postDetail: null));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    // print('#POST_DETAIL OBSERVER: $error');
  }

  @override
  void onTransition(Transition<PostDetailEvent, PostDetailState> transition) {
    super.onTransition(transition);
    // print('#POST_DETAIL OBSERVER: $transition');
  }

  @override
  void onEvent(PostDetailEvent event) {
    super.onEvent(event);
    // print('#POST_DETAIL OBSERVER: $event');
  }

  @override
  void onChange(Change<PostDetailState> change) {
    super.onChange(change);
    // print('#POST_DETAIL OBSERVER: ${change.currentState} ---> ${change.nextState}' );
  }
}