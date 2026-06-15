import 'package:flutter/material.dart';
import 'package:inttask/app/constants/app_strings.dart';
import 'package:inttask/app/theme/app_colors.dart';
import 'package:inttask/app/theme/app_spacing.dart';
import 'package:inttask/app/theme/app_text_styles.dart';
import 'package:inttask/data/models/comment_model.dart';
import 'package:inttask/utils/time_ago_helper.dart';
import 'package:inttask/widgets/comments/network_image_widget.dart';

class CommentsPreviewWidget extends StatelessWidget {
  final CommentModel? comment;
  final int commentCount;
  final bool isMediaPost;
  final VoidCallback? onViewMoreTap;

  const CommentsPreviewWidget({
    super.key,
    this.comment,
    required this.commentCount,
    this.isMediaPost = true,
    this.onViewMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    if (commentCount == 0 || comment == null) {
      return const SizedBox.shrink();
    }

    final bgColor =
        isMediaPost ? AppColors.commentPinkBg : AppColors.commentGreyBg;
    final avatarOnRight = !isMediaPost;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppSpacing.commentRadius),
          ),
          child: avatarOnRight
              ? _buildCommentContentRightAvatar(comment!)
              : _buildCommentContentLeftAvatar(comment!),
        ),
        if (commentCount > 1) ...[
          const SizedBox(height: AppSpacing.sm),
          GestureDetector(
            onTap: onViewMoreTap,
            child: Text(
              AppStrings.viewMoreComments,
              style: AppTextStyles.viewMoreComments,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCommentContentLeftAvatar(CommentModel comment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NetworkImageWidget(
          imageUrl: comment.userImage,
          size: AppSpacing.avatarSizeTiny,
          isCircular: true,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: _buildCommentBody(comment)),
      ],
    );
  }

  Widget _buildCommentContentRightAvatar(CommentModel comment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildCommentBody(comment)),
        const SizedBox(width: AppSpacing.sm),
        NetworkImageWidget(
          imageUrl: comment.userImage,
          size: AppSpacing.avatarSizeTiny,
          isCircular: true,
        ),
      ],
    );
  }

  Widget _buildCommentBody(CommentModel comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comment.username.isNotEmpty
              ? comment.username
              : AppStrings.unknownUser,
          style: AppTextStyles.commentUsername,
        ),
        const SizedBox(height: AppSpacing.xs),
        if (comment.isImageComment)
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            child: NetworkImageWidget(
              imageUrl: comment.comments,
              width: 120,
              height: 90,
              borderRadius: AppSpacing.sm,
            ),
          )
        else
          Text(
            comment.comments.isNotEmpty
                ? comment.comments
                : AppStrings.noContent,
            style: AppTextStyles.commentText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          TimeAgoHelper.getTimeAgo(comment.createdDate),
          style: AppTextStyles.commentTime,
        ),
      ],
    );
  }
}
