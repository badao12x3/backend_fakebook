import 'package:equatable/equatable.dart';
import 'package:fakebook_frontend/models/blocked_account_model.dart';

abstract class BlockedAccountsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BlockedAccountsFetched extends BlockedAccountsEvent {}

class BlockById extends BlockedAccountsEvent {
  final String id;
  BlockById({required this.id});
}

class RemoveBlockById extends BlockedAccountsEvent {
  final String id;
  RemoveBlockById({required this.id});
}

class BlockedAccountsReload extends BlockedAccountsEvent {}
