import 'package:equatable/equatable.dart';
import 'package:fakebook_frontend/models/blocked_account_model.dart';

abstract class BlockedAccountsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BlockedAccountsFetched extends BlockedAccountsEvent {}

class BlockedAccountsReload extends BlockedAccountsEvent {}
