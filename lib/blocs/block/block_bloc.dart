import 'package:fakebook_frontend/blocs/block/block_event.dart';
import 'package:fakebook_frontend/blocs/block/block_state.dart';
import 'package:fakebook_frontend/models/blocked_account_model.dart';
import 'package:fakebook_frontend/repositories/block_repository.dart';
import 'package:fakebook_frontend/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockedAccountsBloc
    extends Bloc<BlockedAccountsEvent, BlockedAccountsState> {
  late final BlockRepository blockRepository;
  BlockedAccountsBloc({required this.blockRepository})
      : super(BlockedAccountsState.initial()) {
    on<BlockedAccountsFetched>(_onBlockedAccountsFetched);
    on<BlockById>(_onBlockById);
    on<RemoveBlockById>(_onRemoveBlockById);
  }

  Future<void> _onBlockedAccountsFetched(
      BlockedAccountsFetched event, Emitter<BlockedAccountsState> emit) async {
    try {
      emit(BlockedAccountsState(
          blockedAccountsStatus: BlockedAccountsStatus.loading));
      final List<BlockedAccount>? blockedAccounts =
          await blockRepository.fetchBlock();
      if (blockedAccounts != null) {
        emit(BlockedAccountsState(
            blockedAccountsStatus: BlockedAccountsStatus.success,
            blockedAccounts: blockedAccounts));
      }
    } catch (error) {
      emit(BlockedAccountsState(
          blockedAccountsStatus: BlockedAccountsStatus.failure,
          blockedAccounts: null));
    }
  }

  Future<void> _onBlockById(
      BlockById event, Emitter<BlockedAccountsState> emit) async {
    try {
      emit(BlockedAccountsState(
          blockedAccountsStatus: BlockedAccountsStatus.loading));
      print("iddd" + event.id);
      final isSuccess = await blockRepository.blockById(id: event.id);
      if (isSuccess) {
        print("dumadcroi");
        final List<BlockedAccount>? blockedAccounts =
            await blockRepository.fetchBlock();
        emit(BlockedAccountsState(
            blockedAccountsStatus: BlockedAccountsStatus.success,
            blockedAccounts: blockedAccounts));
      }
    } catch (error) {
      emit(BlockedAccountsState(
          blockedAccountsStatus: BlockedAccountsStatus.failure,
          blockedAccounts: null));
    }
  }

  Future<void> _onRemoveBlockById(
      RemoveBlockById event, Emitter<BlockedAccountsState> emit) async {
    try {
      emit(BlockedAccountsState(
          blockedAccountsStatus: BlockedAccountsStatus.loading));
      final isSuccess = await blockRepository.removeBlockById(id: event.id);
      if (isSuccess) {
        final List<BlockedAccount>? blockedAccounts =
            await blockRepository.fetchBlock();
        emit(BlockedAccountsState(
            blockedAccountsStatus: BlockedAccountsStatus.success,
            blockedAccounts: blockedAccounts));
      }
    } catch (error) {
      emit(BlockedAccountsState(
          blockedAccountsStatus: BlockedAccountsStatus.failure,
          blockedAccounts: null));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print('#BLOCK OBSERVER: $error');
  }

  @override
  void onTransition(
      Transition<BlockedAccountsEvent, BlockedAccountsState> transition) {
    super.onTransition(transition);
    // print('#BLOCK OBSERVER: $transition');
  }

  @override
  void onEvent(BlockedAccountsEvent event) {
    super.onEvent(event);
    print('#BLOCK OBSERVER: $event');
  }

  @override
  void onChange(Change<BlockedAccountsState> change) {
    super.onChange(change);
    print('#BLOCK OBSERVER: ${change.currentState} ---> ${change.nextState}');
  }
}
