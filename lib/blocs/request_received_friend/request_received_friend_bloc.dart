import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:fakebook_frontend/blocs/request_received_friend/request_received_friend_event.dart';
import 'package:fakebook_frontend/blocs/request_received_friend/request_received_friend_state.dart';
import 'package:fakebook_frontend/repositories/request_received_friend_repository.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class RequestReceivedFriendBloc
    extends Bloc<RequestReceivedFriendEvent, RequestReceivedFriendState> {
  late final FriendRequestReceivedRepository friendRequestReceivedRepository;

  RequestReceivedFriendBloc() : super(RequestReceivedFriendState.initial()) {
    friendRequestReceivedRepository = FriendRequestReceivedRepository();
    on<RequestReceivedFriendFetched>(
      _onRequestReceivedFriendFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onRequestReceivedFriendFetched(
      RequestReceivedFriendFetched event,
      Emitter<RequestReceivedFriendState> emit) async {
    try {
      final friendRequestReceivedListData =
          await friendRequestReceivedRepository.fetchRequestReceivedFriends();
      if (!friendRequestReceivedListData.requestReceivedFriendList.isEmpty) {
        state.friendRequestReceivedList.requestReceivedFriendList =
            friendRequestReceivedListData.requestReceivedFriendList;
        emit(state.copyWith(
            requestReceivedFriendList: state.friendRequestReceivedList));
      }
    } catch (_) {
      emit(state.copyWith());
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print('#POST OBSERVER: $error');
  }

  @override
  void onEvent(RequestReceivedFriendEvent event) {
    super.onEvent(event);
    print('#POST OBSERVER 123: $event');
  }
}