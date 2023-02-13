import 'package:equatable/equatable.dart';
import 'package:fakebook_frontend/models/models.dart';
import 'package:image_picker/image_picker.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {}

class PostReload extends PostEvent {}

class PostLike extends PostEvent {
  final Post post;
  PostLike({required this.post});
}

class PostAdd extends PostEvent {
  final String described;
  final String? status;
  final List<XFile>? imageFileList;
  PostAdd({required this.described, this.status, this.imageFileList});
}