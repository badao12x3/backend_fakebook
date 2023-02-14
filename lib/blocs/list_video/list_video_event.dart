

import 'package:equatable/equatable.dart';

import '../../models/video_model.dart';

abstract class ListVideoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ListVideoFetched extends ListVideoEvent {}

class ListVideoReload extends ListVideoEvent {}

class VideoPostLike extends ListVideoEvent {
  final VideoElement video;
  VideoPostLike({required this.video});
}