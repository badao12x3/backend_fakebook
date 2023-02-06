import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fakebook_frontend/models/models.dart';
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

    on<PostReload>(
      _onPostReload,
      transformer: throttleDroppable(throttleDuration),
    );

    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );

    on<LikePost>(_onLikePost);
  }

  void _onPostReload(PostReload event, Emitter<PostState> emit) {
    try {
      return emit(
        state.copyWith(
          status: PostStatus.initial,
          postList: PostList.initial(),
          hasReachedMax: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
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
      final postListLength = state.postList.posts.length;
      final finalPost = state.postList.posts[postListLength-1] as Post;
      final postList = await _postRepository.fetchPosts(startIndex: postListLength, last_id: state.postList.last_id);
      emit(state.copyWith(status: PostStatus.loading));
      if(postList.posts.isEmpty)
          emit(state.copyWith(status: PostStatus.success, hasReachedMax: true));
      else {
            state.postList.posts.addAll(postList.posts);
            state.postList.last_id = postList.last_id;
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

  Future<void> _onLikePost(LikePost event, Emitter<PostState> emit) async {

  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print('#POST OBSERVER: $error');
  }

  @override
  void onTransition(Transition<PostEvent, PostState> transition) {
    super.onTransition(transition);
    // print('#POST OBSERVER: $transition');
  }

  @override
  void onEvent(PostEvent event) {
    super.onEvent(event);
    print('#POST OBSERVER: $event');
  }

  @override
  void onChange(Change<PostState> change) {
    super.onChange(change);
    print('#POST OBSERVER: { stateCurrent: ${change.currentState.postList.posts.length}, last_idCurrent: ${change.currentState.postList.last_id}, statusCurrent: ${change.currentState.status}, hasReachedMaxCurrent: ${change.currentState.hasReachedMax} }');
    print('#POST OBSERVER: { stateNext: ${change.nextState.postList.posts.length}, last_idNext: ${change.nextState.postList.last_id}, statusNext: ${change.nextState.status}, hasReachedMaxCurrentNext: ${change.nextState.hasReachedMax}}');
  }
}