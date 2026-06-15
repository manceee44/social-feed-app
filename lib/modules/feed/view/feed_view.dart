import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inttask/app/constants/app_strings.dart';
import 'package:inttask/app/theme/app_colors.dart';
import 'package:inttask/modules/feed/controller/feed_controller.dart';
import 'package:inttask/widgets/common/app_error_widget.dart';
import 'package:inttask/widgets/common/app_loader.dart';
import 'package:inttask/widgets/common/empty_state_widget.dart';
import 'package:inttask/widgets/post/post_card.dart';

class FeedView extends GetView<FeedController> {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.postList),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const AppLoader(message: 'Loading posts...');
        }

        if (controller.hasError.value) {
          return AppErrorWidget(
            message: controller.errorMessage.value,
            onRetry: controller.fetchPosts,
            icon: Icons.wifi_off_rounded,
          );
        }

        if (controller.isEmpty) {
          return EmptyStateWidget(
            title: AppStrings.emptyFeedTitle,
            message: AppStrings.emptyFeedMessage,
            icon: Icons.feed_outlined,
            onAction: controller.fetchPosts,
            actionLabel: AppStrings.retry,
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshPosts,
          color: AppColors.primary,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return PostCard(key: ValueKey(post.postId), post: post);
            },
          ),
        );
      }),
    );
  }
}
