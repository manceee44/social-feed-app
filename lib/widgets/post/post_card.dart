import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inttask/app/routes/app_routes.dart';
import 'package:inttask/app/theme/app_spacing.dart';
import 'package:inttask/data/models/post_model.dart';
import 'package:inttask/widgets/post/comments_preview_widget.dart';
import 'package:inttask/widgets/post/expandable_text_widget.dart';
import 'package:inttask/widgets/post/post_actions.dart';
import 'package:inttask/widgets/post/post_header.dart';
import 'package:inttask/widgets/post/post_image.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onTap;

  const PostCard({
    super.key,
    required this.post,
    this.onTap,
  });

  void _navigateToDetails() {
    Get.toNamed(AppRoutes.postDetails, arguments: post);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPadding,
        vertical: AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(post: post),
          const SizedBox(height: AppSpacing.md),
          if (post.isMediaPost && post.mediaUrl != null) ...[
            PostImage(imageUrl: post.mediaUrl, aspectRatio: 3 / 4),
            const SizedBox(height: AppSpacing.md),
          ],
          if (post.isTextPost || post.textContent.isNotEmpty) ...[
            ExpandableTextWidget(
              text: post.textContent.isNotEmpty
                  ? post.textContent
                  : post.fullTextContent,
              trimLines: 2,
              useSerifFont: post.isTextPost,
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          PostActions(
            likes: post.likes,
            comments: post.commentCount,
            isLiked: post.isLiked,
            onCommentTap: _navigateToDetails,
          ),
          if (post.commentCount > 0 && post.firstComment != null) ...[
            const SizedBox(height: AppSpacing.md),
            CommentsPreviewWidget(
              comment: post.firstComment,
              commentCount: post.commentCount,
              isMediaPost: post.isMediaPost,
              onViewMoreTap: onTap ?? _navigateToDetails,
            ),
          ],
        ],
      ),
    );
  }
}
