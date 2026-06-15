import 'package:flutter/material.dart';
import 'package:inttask/app/constants/app_strings.dart';
import 'package:inttask/app/theme/app_colors.dart';
import 'package:inttask/app/theme/app_spacing.dart';
import 'package:inttask/app/theme/app_text_styles.dart';
import 'package:inttask/data/models/comment_model.dart';
import 'package:inttask/utils/time_ago_helper.dart';
import 'package:inttask/widgets/comments/network_image_widget.dart';
import 'package:inttask/widgets/comments/reply_tile.dart';

class CommentTile extends StatelessWidget {
  final CommentModel comment;
  final int depth;
  final bool showReplyButton;

  const CommentTile({
    super.key,
    required this.comment,
    this.depth = 0,
    this.showReplyButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: depth * AppSpacing.xl,
            bottom: AppSpacing.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (depth > 0) _buildThreadLine(),
              NetworkImageWidget(
                imageUrl: comment.userImage,
                size: AppSpacing.avatarSizeSmall,
                isCircular: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCommentBubble(),
                    if (showReplyButton) ...[
                      const SizedBox(height: AppSpacing.xs),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          AppStrings.reply,
                          style: AppTextStyles.reply,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        if (comment.hasReplies)
          ...comment.replies.map(
            (reply) => ReplyTile(
              reply: reply,
              depth: depth + 1,
            ),
          ),
      ],
    );
  }

  Widget _buildThreadLine() {
    return SizedBox(
      width: 20,
      child: CustomPaint(
        painter: _ThreadLinePainter(),
        size: const Size(20, 40),
      ),
    );
  }

  Widget _buildCommentBubble() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.commentGreyBg,
        borderRadius: BorderRadius.circular(AppSpacing.commentRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.username.isNotEmpty
                ? comment.username
                : AppStrings.unknownUser,
            style: AppTextStyles.commentUsername,
          ),
          const SizedBox(height: AppSpacing.xs),
          _buildCommentContent(),
          const SizedBox(height: AppSpacing.xs),
          Text(
            TimeAgoHelper.getTimeAgo(comment.createdDate),
            style: AppTextStyles.commentTime,
          ),
        ],
      ),
    );
  }

  Widget _buildCommentContent() {
    if (comment.isImageComment) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        child: NetworkImageWidget(
          imageUrl: comment.comments,
          width: 160,
          height: 120,
          borderRadius: AppSpacing.sm,
        ),
      );
    }

    if (comment.isReply && comment.replyToUserName != null) {
      return _buildReplyText();
    }

    return Text(
      comment.comments.isNotEmpty ? comment.comments : AppStrings.noContent,
      style: AppTextStyles.commentText,
    );
  }

  Widget _buildReplyText() {
    final replyTo = comment.replyToUserName ?? '';
    final text = comment.comments;

    if (replyTo.isEmpty) {
      return Text(text, style: AppTextStyles.commentText);
    }

    return RichText(
      text: TextSpan(
        style: AppTextStyles.commentText,
        children: [
          TextSpan(
            text: '@$replyTo ',
            style: AppTextStyles.mention,
          ),
          TextSpan(text: text),
        ],
      ),
    );
  }
}

class _ThreadLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.divider
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width * 0.5, size.height * 0.6)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.75,
        size.width,
        size.height * 0.75,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
