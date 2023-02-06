import 'package:equatable/equatable.dart';
import 'package:fakebook_frontend/models/models.dart';

class PostList {
  final List<Post> posts;
  int new_items; // bỏ final
  String last_id; // bỏ final

  PostList({required this.posts, required this.new_items, required this.last_id});

  PostList.initial(): posts = List<Post>.empty(growable: true), new_items = 0, last_id = '';

  // tên là fromMap thì hợp lý hơn
  factory PostList.fromJson(Map<String, dynamic> json) {
    final postsData = json['data']['posts'] as List<dynamic>?;
    final posts = postsData != null ? postsData.map((postData) => Post.fromJson(postData)).toList() : <Post>[];
    return PostList(
      posts: posts,
      new_items: json['data']['new_items'],
      last_id: json['data']['last_id']
    );
  }

  // tên là toMap thì hợp lý hơn
  Map<String, dynamic> toJson() {
    return {
      'posts': posts.map((post) => post.toJson()).toList(),
      'new_items': new_items,
      'last_id': last_id
    };
  }

  @override
  String toString() => toJson().toString();

}

class Post extends Equatable {
  final String id;
  final String described;
  final String createdAt;
  final String updatedAt;
  final List<AttachedImage>? images;
  final AttachedVideo? video;
  // final List<int>? likedAccounts;
  // final List<int>? commentList;
  final int likes;
  final int comments;
  final Author author;
  final bool isLiked;
  final bool isBlocked;
  final String? status;
  final bool canComment;
  final bool canEdit;
  final bool banned;

  Post({required this.id, required this.described, required this.createdAt, required this.updatedAt, this.images, this.video, required this.likes, required this.comments, required this.author, required this.isLiked, required this.isBlocked, this.status, required this.canComment, required this.canEdit, required this.banned});

  factory Post.fromJson(Map<String, dynamic> json) {
    final imagesData = json["images"] as List<dynamic>?;
    final images = imagesData != null ? imagesData.map((imageData) => AttachedImage.fromJson(imageData)).toList() : null;
    return Post(
      id: json["id"] as String,
      described: json["described"] as String,
      createdAt: json["createdAt"] as String,
      updatedAt: json["updatedAt"] as String,
      images: images,
      likes: json["likes"] as int,
      comments: json["comments"] as int,
      author: Author.fromJson(json["author"]) as Author,
      isLiked: json["is_liked"] as bool,
      status: json["status"] as String?,
      isBlocked: json["is_blocked"] as bool,
      canEdit: json["can_edit"] as bool,
      banned: json["banned"] as bool,
      canComment: json["can_comment"] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "described": described,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "likes": likes,
      "comments": comments,
      "author": author.toJson(),
      "is_liked": isLiked,
      if(status != null) "status": status,
      "is_blocked": isBlocked,
      "can_edit": canEdit,
      "banned": banned,
      "can_comment": canComment,
    };
  }

  @override
  List<Object?> get props {
    return [id, described, createdAt, updatedAt, images, video, likes, comments, author,
      isLiked, isBlocked, status, canComment, canEdit, banned];
  }

  @override
  String toString() => toJson().toString();

}


class AttachedImage extends Equatable {
  final String? filename;
  final String url;
  final String? publicId;

  AttachedImage({this.filename, required this.url, this.publicId});

  AttachedImage copyWith(String? filename, String? url, String? publicId) {
    return AttachedImage(
        filename: filename ?? this.filename,
        url: url ?? this.url,
        publicId: publicId ?? this.publicId
    );
  }

  factory AttachedImage.fromJson(Map<String, dynamic> json) {
    return AttachedImage(filename: json['filename'] as String?, url: json['url'] as String, publicId: json['publicId'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      if(publicId != null) 'publicId': publicId
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [filename, url, publicId];

  @override
  String toString() => toJson().toString();
}

class AttachedVideo extends Equatable {
  final String? filename;
  final String url;
  final String? publicId;

  AttachedVideo({this.filename, required this.url, this.publicId});

  AttachedVideo copyWith(String? filename, String? url, String? publicId) {
    return AttachedVideo(
        filename: filename ?? this.filename,
        url: url ?? this.url,
        publicId: publicId ?? this.publicId
    );
  }

  factory AttachedVideo.fromJson(Map<String, dynamic> json) {
    return AttachedVideo(filename: json['filename'] as String?, url: json['url'] as String, publicId: json['publicId'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      if(publicId != null) 'publicId': publicId
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [filename, url, publicId];

  @override
  String toString() => toJson().toString();
}


class Author extends Equatable {
    final String id;
    final String name;
    final String avatar;

    Author({required this.id, required this.name, required this.avatar});

    Author copyWith({String? id, String? name, String? avatar}) {
      return Author(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
      );
    }

    factory Author.fromJson(Map<String, dynamic> json) {
      return Author(
        id: json["id"] as String,
        name: json["name"] as String,
        avatar: json["avatar"] as String,
      );
    }

    Map<String, dynamic> toJson() {
      return {
        "id": id,
        "name": name,
        "avatar": avatar,
      };
    }

    @override
    List<Object> get props {
      return [id, name, avatar];
    }

    @override
    String toString() => toJson().toString();

}