import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fakebook_frontend/blocs/personal_info/personal_info_event.dart';
import 'package:fakebook_frontend/blocs/personal_info/personal_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../repositories/personal_repository.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  late final UserInfoRepository userInfoRepository;

  PersonalInfoBloc() : super(PersonalInfoState.initial()) {
    userInfoRepository = UserInfoRepository();
    on<PersonalInfoFetched>(
      _onPersonalInfoFetched,
      transformer: throttleDroppable(throttleDuration),
    );

    on<PersonalInfoOfAnotherUserFerched>(
      _onPersonalInfoOfAnotherUserFerched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onPersonalInfoFetched(
      PersonalInfoFetched event, Emitter<PersonalInfoState> emit) async {
    try {
      final userInfoData = await userInfoRepository.fetchPersonalInfo();
      emit(PersonalInfoState(userInfo: userInfoData));
    } catch (_) {
      emit(state.copyWith());
    }
  }

  Future<void> _onPersonalInfoOfAnotherUserFerched(
      PersonalInfoOfAnotherUserFerched event,
      Emitter<PersonalInfoState> emit) async {
    try {
      final String id = event.id;
      final userInfoData =
          await userInfoRepository.fetchPersonalInfoOfAnotherUser(id);
      emit(PersonalInfoState(userInfo: userInfoData));
    } catch (_) {
      emit(state.copyWith());
    }
  }


  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    // print('#PERSONAL INFO OBSERVER: $error');
  }

  @override
  void onEvent(PersonalInfoEvent event) {
    super.onEvent(event);
    print('#PERSONAL INFO OBSERVER: $event');
  }

  @override
  void onChange(Change<PersonalInfoState> change) {
    super.onChange(change);
    print('#PERSONAL INFO OBSERVER: ${change.currentState} ---> ${change.nextState}' );
  }
}
