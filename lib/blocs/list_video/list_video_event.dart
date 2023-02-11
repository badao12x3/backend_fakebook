import 'package:equatable/equatable.dart';

abstract class ListVideoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ListVideoFetched extends ListVideoEvent {}

class ListVideoReload extends ListVideoEvent {}
