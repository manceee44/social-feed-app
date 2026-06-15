import 'package:inttask/data/models/comment_model.dart';
import 'package:inttask/data/models/post_content_model.dart';

class PostModel {
  final String postId;
  final String userId;
  final String username;
  final String userImage;
  final String profession;
  final String city;
  final String country;
  final String postTitle;
  final String? postSubtitle;
  final String postDescription;
  final String isLike;
  final String? reactionType;
  final String date;
  final String time;
  final int commentCount;
  final List<PostContentModel> postContent;
  final int likes;
  final List<CommentModel> postComments;

  const PostModel({
    required this.postId,
    required this.userId,
    required this.username,
    required this.userImage,
    required this.profession,
    required this.city,
    required this.country,
    required this.postTitle,
    this.postSubtitle,
    required this.postDescription,
    required this.isLike,
    this.reactionType,
    required this.date,
    required this.time,
    required this.commentCount,
    required this.postContent,
    required this.likes,
    required this.postComments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final contentList = json['postContent'] as List<dynamic>? ?? [];
    final commentsList = json['postComments'] as List<dynamic>? ?? [];

    return PostModel(
      postId: json['post_id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      userImage: json['user_image']?.toString() ?? '',
      profession: json['profession']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      postTitle: json['post_title']?.toString() ?? '',
      postSubtitle: json['post_subtitle']?.toString(),
      postDescription: json['post_description']?.toString() ?? '',
      isLike: json['is_like']?.toString() ?? '0',
      reactionType: json['reaction_type']?.toString(),
      date: json['date']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      commentCount: int.tryParse(json['comments']?.toString() ?? '0') ?? 0,
      postContent: contentList
          .map((e) => PostContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes: json['likes'] as int? ?? 0,
      postComments: commentsList
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  bool get isMediaPost {
    if (postContent.isEmpty) return false;
    return postContent.first.isImage;
  }

  bool get isTextPost {
    if (postContent.isEmpty) return true;
    return postContent.first.isText;
  }

  String? get mediaUrl {
    for (final content in postContent) {
      if (content.isImage && content.post.isNotEmpty) {
        return content.post;
      }
    }
    return null;
  }

  String get textContent {
    for (final content in postContent) {
      if (content.isText && content.post.isNotEmpty) {
        return content.post;
      }
    }
    if (postDescription.isNotEmpty) return postDescription;
    if (postTitle.isNotEmpty) return postTitle;
    return '';
  }

  String get fullTextContent {
    final buffer = StringBuffer();
    if (postTitle.isNotEmpty) {
      buffer.writeln(postTitle);
    }
    if (postSubtitle != null && postSubtitle!.isNotEmpty) {
      buffer.writeln(postSubtitle);
    }
    if (postDescription.isNotEmpty) {
      buffer.writeln(postDescription);
    }
    final contentText = textContent;
    if (contentText.isNotEmpty &&
        contentText != postDescription &&
        contentText != postTitle) {
      buffer.writeln(contentText);
    }
    return buffer.toString().trim();
  }

  String get location {
    final parts = <String>[];
    if (city.isNotEmpty) parts.add(city);
    if (country.isNotEmpty) parts.add(country);
    return parts.isEmpty ? '' : parts.join(', ');
  }

  String? get groupName =>
      postSubtitle != null && postSubtitle!.isNotEmpty ? postSubtitle : null;

  bool get hasGroupContext =>
      groupName != null && postTitle.isNotEmpty && isTextPost;

  CommentModel? get firstComment =>
      postComments.isNotEmpty ? postComments.first : null;

  bool get isLiked => isLike == '1';
}
