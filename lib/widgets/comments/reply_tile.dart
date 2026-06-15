import 'package:flutter/material.dart';
import 'package:inttask/data/models/comment_model.dart';
import 'package:inttask/widgets/comments/comment_tile.dart';

class ReplyTile extends StatelessWidget {
  final CommentModel reply;
  final int depth;

  const ReplyTile({
    super.key,
    required this.reply,
    required this.depth,
  });

  @override
  Widget build(BuildContext context) {
    return CommentTile(
      comment: reply,
      depth: depth,
      showReplyButton: true,
    );
  }
}
