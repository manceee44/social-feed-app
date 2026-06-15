class CommentModel {
  final int commentId;
  final String commentType;
  final String comments;
  final int userId;
  final String userImage;
  final String username;
  final int createdDate;
  final int modifiedDate;
  final int? replyToUserId;
  final String? replyToUserName;
  final List<CommentModel> replies;

  const CommentModel({
    required this.commentId,
    required this.commentType,
    required this.comments,
    required this.userId,
    required this.userImage,
    required this.username,
    required this.createdDate,
    required this.modifiedDate,
    this.replyToUserId,
    this.replyToUserName,
    this.replies = const [],
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    final repliesList = json['replies'] as List<dynamic>? ?? [];

    return CommentModel(
      commentId: json['comment_id'] as int? ?? 0,
      commentType: json['commentType']?.toString() ?? 'text',
      comments: json['comments']?.toString() ?? '',
      userId: json['user_id'] as int? ?? 0,
      userImage: json['user_image']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      createdDate: json['created_date'] as int? ?? 0,
      modifiedDate: json['modified_date'] as int? ?? 0,
      replyToUserId: json['reply_to_user_id'] as int?,
      replyToUserName: json['replyToUserName']?.toString(),
      replies: repliesList
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  bool get isImageComment => commentType.toLowerCase() == 'image';
  bool get isTextComment => commentType.toLowerCase() == 'text';
  bool get hasReplies => replies.isNotEmpty;
  bool get isReply => replyToUserId != null || replyToUserName != null;
}
