import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:fakebook_frontend/blocs/post/post_event.dart';
import 'package:fakebook_frontend/blocs/post/post_state.dart';
import 'package:fakebook_frontend/repositories/post_repository.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  late final PostRepository _postRepository;

  PostBloc() : super(PostState.initial()) {
    _postRepository = PostRepository();

    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onPostFetched(PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final postList = await _postRepository.fetchPosts();
        // print('Length: ${postList.posts.length}');
        emit(state.copyWith(status: PostStatus.loading));
        return emit(
          state.copyWith(
            status: PostStatus.success,
            postList: postList,
            hasReachedMax: false,
          ),
        );
      }
      final postList = await _postRepository.fetchPosts(startIndex: state.postList.posts.length);

      emit(state.copyWith(status: PostStatus.loading));
      if(postList.posts.isEmpty)
          emit(state.copyWith(hasReachedMax: true));
      else {
            state.postList.posts.addAll(postList.posts);
            emit(
              state.copyWith(
                status: PostStatus.success,
                postList: state.postList,
                hasReachedMax: false,
              )
            );
      }

    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}