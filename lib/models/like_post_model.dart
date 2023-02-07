class LikePostModel {
  final String code;
  final String message;
  final int likes;

  LikePostModel({required this.code, required this.message, required this.likes});

  LikePostModel.nullData(): code = '', message = '', likes = 0;

  LikePostModel copyWith({String? code, String? message, int? likes}) {
    return LikePostModel(
      code: code ?? this.code,
      message: message ?? this.message,
      likes: likes ?? this.likes
    );
  }

  factory LikePostModel.fromJson(Map<String, dynamic> json) {
    return LikePostModel(
      code: json["code"],
      message: json["message"],
      likes: json["data"]["likes"], // mấy test case lỗi, sẽ dính null, nên hết sức cẩn thận
    );
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "likes": likes,
  };

  @override
  String toString() => toJson().toString();
}