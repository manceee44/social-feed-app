import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inttask/app/constants/app_strings.dart';
import 'package:inttask/app/theme/app_colors.dart';
import 'package:inttask/app/theme/app_spacing.dart';
import 'package:inttask/data/models/post_model.dart';
import 'package:inttask/modules/post_details/controller/post_details_controller.dart';
import 'package:inttask/widgets/comments/comment_tile.dart';
import 'package:inttask/widgets/common/empty_state_widget.dart';
import 'package:inttask/widgets/post/expandable_text_widget.dart';
import 'package:inttask/widgets/post/post_actions.dart';
import 'package:inttask/widgets/post/post_header.dart';
import 'package:inttask/widgets/post/post_image.dart';

class PostDetailsView extends GetView<PostDetailsController> {
  const PostDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.postDetails),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final post = controller.post.value;
        if (post == null) {
          return const Center(child: Text('Post not found'));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostHeader(post: post, showFullHeader: true),
                    const SizedBox(height: AppSpacing.lg),
                    _buildPostContent(post),
                    const SizedBox(height: AppSpacing.lg),
                    const Divider(color: AppColors.divider),
                    PostActions(
                      likes: post.likes,
                      comments: post.commentCount,
                      isLiked: post.isLiked,
                      showShare: false,
                      usePrimaryIcons: true,
                    ),
                    const Divider(color: AppColors.divider),
                  ],
                ),
              ),
              _buildCommentsSection(post),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPostContent(PostModel post) {
    if (post.isMediaPost && post.mediaUrl != null) {
      return PostImage(
        imageUrl: post.mediaUrl,
        aspectRatio: 3 / 4,
      );
    }

    return ExpandableTextWidget(
      text: post.fullTextContent.isNotEmpty
          ? post.fullTextContent
          : post.textContent,
      expandable: false,
      useSerifFont: post.isTextPost,
    );
  }

  Widget _buildCommentsSection(PostModel post) {
    if (post.postComments.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.horizontalPadding),
        child: EmptyStateWidget(
          title: AppStrings.emptyCommentsTitle,
          message: AppStrings.emptyCommentsMessage,
          icon: Icons.chat_bubble_outline,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPadding,
        vertical: AppSpacing.sm,
      ),
      itemCount: post.postComments.length,
      itemBuilder: (context, index) {
        final comment = post.postComments[index];
        return CommentTile(
          key: ValueKey(comment.commentId),
          comment: comment,
        );
      },
    );
  }
}
