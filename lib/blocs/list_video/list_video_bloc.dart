import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fakebook_frontend/blocs/list_video/list_video_event.dart';
import 'package:fakebook_frontend/blocs/list_video/list_video_state.dart';
import 'package:fakebook_frontend/repositories/video_repository.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../models/video_model.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListVideoBloc extends Bloc<ListVideoEvent, ListVideoState> {
  late final VideoRepository videoRepository;

  ListVideoBloc({required this.videoRepository}) : super(ListVideoState.initial()) {
    on<ListVideoReload>(
      _onListVideoReload,
      transformer: throttleDroppable(throttleDuration),
    );

    on<ListVideoFetched>(
      _onListVideoFetched,
      transformer: throttleDroppable(throttleDuration),
    );

    on<VideoPostLike>(_onLikeVideoPost);
  }

  void _onListVideoReload(ListVideoReload event, Emitter<ListVideoState> emit) {
    try {
      return emit(
        state.copyWith(
          status: ListVideoStatus.initial,
          videoList: VideoList.initial()
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: ListVideoStatus.failure));
    }
  }

  Future<void> _onListVideoFetched(ListVideoFetched event, Emitter<ListVideoState> emit) async {
    try {
      if (state.status == ListVideoStatus.initial) {
        final videoListData = await videoRepository.getListVideo();
        emit(state.copyWith(status: ListVideoStatus.loading));
        return emit(
          state.copyWith(
            status: ListVideoStatus.success,
            videoList: videoListData
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: ListVideoStatus.failure));
    }
  }

  Future<void> _onLikeVideoPost(VideoPostLike event, Emitter<ListVideoState> emit) async {
    final mustUpdatePost = event.video as VideoElement;
    final videos = state.videoList.videos as List<VideoElement>;
    final indexOfMustUpdatePost = videos.indexOf(mustUpdatePost);
    int likes = mustUpdatePost.isLiked ? mustUpdatePost.likes - 1 : mustUpdatePost.likes + 1;
    final newUpdatedPost = mustUpdatePost.copyWith(likes: likes, isLiked: !mustUpdatePost.isLiked);
    videos..remove(mustUpdatePost)..insert(indexOfMustUpdatePost, newUpdatedPost);

    emit(state.copyWith(videoList: VideoList(videos: videos)));

    try {
      if (!mustUpdatePost.isLiked){
        final likeVideo = await videoRepository.likeVideo(id: mustUpdatePost.id);
        if (likeVideo.code == '506') {
          // TC1: t??i kho???n c???a m??nh ?????t nhi??n b??? kh??a, c???n chuy???n t???i m??n login ---> Kh??ng l??m ???????c, do kh??ng g???i t???i AuthBloc m?? update state
          // TC2: N???u m??nh block n??/n?? block m??nh th?? kh??ng like ???????c
        } else if (likeVideo.code == '9991') {
          // n???u like ph???i b??i vi???t b??? banned, l??c n??y m??nh ch??a ???n reload ???ng d???ng n??n ch??a get l???i API l???c posts n??n s??? x??a b??i vi???t kh???i UI

        }
      }
      if(mustUpdatePost.isLiked) {
        final unlikeVideo = await videoRepository.unlikeVideo(id: mustUpdatePost.id);
        if (unlikeVideo.code == '507') {
          // TC1: t??i kho???n c???a m??nh ?????t nhi??n b??? kh??a, c???n chuy???n t???i m??n login ---> Kh??ng l??m ???????c, do kh??ng g???i t???i AuthBloc m?? update state
          // TC2: N???u m??nh block n??/n?? block m??nh th?? v???n unlike ???????c ----> kh??ng t???n t???i TC2
        } else if (unlikeVideo.code == '9991') {
          // n???u unlike ph???i b??i vi???t b??? banned, l??c n??y m??nh ch??a ???n reload ???ng d???ng n??n ch??a get l???i API l???c posts n??n s??? x??a b??i vi???t kh???i UI

        }
      }

    } catch(error) {

    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    // print('#VIDEO OBSERVER: $error');
  }

  @override
  void onTransition(Transition<ListVideoEvent, ListVideoState> transition) {
    super.onTransition(transition);
    // print('#POST OBSERVER: $transition');
  }

  @override
  void onEvent(ListVideoEvent event) {
    super.onEvent(event);
    // print('#VIDEO OBSERVER: $event');
  }

  @override
  void onChange(Change<ListVideoState> change) {
    super.onChange(change);
    // print('#VIDEO OBSERVER: { stateCurrent: ${change.currentState.videoList.videos.length}, statusCurrent: ${change.currentState.status} }');
    // print('#VIDEO OBSERVER: { stateNext: ${change.nextState.videoList.videos.length}, statusNext: ${change.nextState.status}}');
  }
}
