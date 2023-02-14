import 'package:fakebook_frontend/models/blocked_account_model.dart';

enum BlockedAccountsStatus { initial, loading, success, failure }

class BlockedAccountsState {
  BlockedAccountsStatus blockedAccountsStatus;
  List<BlockedAccount>? blockedAccounts;

  BlockedAccountsState(
      {required this.blockedAccountsStatus, this.blockedAccounts});
  BlockedAccountsState.initial()
      : blockedAccountsStatus = BlockedAccountsStatus.initial,
        blockedAccounts = null;

  BlockedAccountsState copyWith(
      {BlockedAccountsStatus? blockedAccountsStatus,
      List<BlockedAccount>? blockedAccounts}) {
    return BlockedAccountsState(
        blockedAccountsStatus:
            blockedAccountsStatus ?? this.blockedAccountsStatus,
        blockedAccounts: blockedAccounts ?? this.blockedAccounts);
  }

  @override
  String toString() {
    return {
      'blockedAccountsStatus': blockedAccountsStatus.toString(),
      'blockedAccounts': blockedAccounts.toString()
    }.toString();
  }
}
