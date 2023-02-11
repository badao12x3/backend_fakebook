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
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print('#VIDEO OBSERVER: $error');
  }

  @override
  void onTransition(Transition<ListVideoEvent, ListVideoState> transition) {
    super.onTransition(transition);
    // print('#POST OBSERVER: $transition');
  }

  @override
  void onEvent(ListVideoEvent event) {
    super.onEvent(event);
    print('#VIDEO OBSERVER: $event');
  }

  @override
  void onChange(Change<ListVideoState> change) {
    super.onChange(change);
    print('#VIDEO OBSERVER: { stateCurrent: ${change.currentState.videoList.videos.length}, statusCurrent: ${change.currentState.status} }');
    print('#VIDEO OBSERVER: { stateNext: ${change.nextState.videoList.videos.length}, statusNext: ${change.nextState.status}}');
  }
}
