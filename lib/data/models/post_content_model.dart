class PostContentModel {
  final String postType;
  final String post;
  final String previewImage;

  const PostContentModel({
    required this.postType,
    required this.post,
    required this.previewImage,
  });

  factory PostContentModel.fromJson(Map<String, dynamic> json) {
    return PostContentModel(
      postType: json['postType']?.toString() ?? 'text',
      post: json['post']?.toString() ?? '',
      previewImage: json['preview_image']?.toString() ?? '',
    );
  }

  bool get isImage => postType.toLowerCase() == 'image';
  bool get isText => postType.toLowerCase() == 'text';
}
