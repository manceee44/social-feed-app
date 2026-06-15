import 'package:flutter/material.dart';
import 'package:inttask/app/constants/app_strings.dart';
import 'package:inttask/app/theme/app_colors.dart';
import 'package:inttask/app/theme/app_spacing.dart';
import 'package:inttask/app/theme/app_text_styles.dart';
import 'package:inttask/data/models/post_model.dart';
import 'package:inttask/utils/date_formatter.dart';
import 'package:inttask/widgets/common/app_network_image.dart';

class PostHeader extends StatelessWidget {
  final PostModel post;
  final bool showFullHeader;

  const PostHeader({
    super.key,
    required this.post,
    this.showFullHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppNetworkImage(
          imageUrl: post.userImage,
          width: AppSpacing.avatarSize,
          height: AppSpacing.avatarSize,
          isCircular: true,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (post.hasGroupContext) _buildGroupHeader() else _buildUserHeader(),
              const SizedBox(height: 2),
              Text(
                _buildMetadata(),
                style: AppTextStyles.metadata,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz, color: AppColors.textSecondary),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildUserHeader() {
    return Text(
      post.username.isNotEmpty ? post.username : AppStrings.unknownUser,
      style: AppTextStyles.username,
    );
  }

  Widget _buildGroupHeader() {
    return RichText(
      maxLines: showFullHeader ? null : 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: AppTextStyles.body,
        children: [
          TextSpan(
            text: post.username.isNotEmpty ? post.username : AppStrings.unknownUser,
            style: AppTextStyles.username,
          ),
          TextSpan(
            text: ' ${AppStrings.postedIn} ',
            style: AppTextStyles.postedIn,
          ),
          TextSpan(
            text: post.groupName ?? post.postTitle,
            style: AppTextStyles.groupName,
          ),
        ],
      ),
    );
  }

  String _buildMetadata() {
    final location = post.location.isNotEmpty
        ? post.location
        : AppStrings.unknownLocation;
    final dateTime = DateFormatter.formatPostDateTime(post.date, post.time);

    if (dateTime.isEmpty) return location;
    return '$location | $dateTime';
  }
}
