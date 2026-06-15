import 'package:flutter/material.dart';
import 'package:inttask/app/theme/app_colors.dart';
import 'package:inttask/app/theme/app_spacing.dart';
import 'package:inttask/app/theme/app_text_styles.dart';

class PostActions extends StatelessWidget {
  final int likes;
  final int comments;
  final bool isLiked;
  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onShareTap;
  final bool showShare;
  final bool usePrimaryIcons;

  const PostActions({
    super.key,
    required this.likes,
    required this.comments,
    this.isLiked = false,
    this.onLikeTap,
    this.onCommentTap,
    this.onShareTap,
    this.showShare = true,
    this.usePrimaryIcons = false,
  });

  Color get _iconColor =>
      usePrimaryIcons ? AppColors.primary : AppColors.textPrimary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionButton(
          icon: isLiked ? Icons.favorite : Icons.favorite_border,
          count: likes,
          color: isLiked || usePrimaryIcons ? AppColors.primary : _iconColor,
          onTap: onLikeTap ?? () {},
        ),
        const SizedBox(width: AppSpacing.xl),
        _ActionButton(
          icon: comments > 0 && !usePrimaryIcons
              ? Icons.chat_bubble
              : Icons.chat_bubble_outline_rounded,
          count: comments,
          color: comments > 0 && !usePrimaryIcons
              ? AppColors.primary
              : _iconColor,
          filled: comments > 0 && !usePrimaryIcons,
          onTap: onCommentTap,
        ),
        if (showShare) ...[
          const Spacer(),
          InkWell(
            onTap: onShareTap ?? () {},
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            child: const Padding(
              padding: EdgeInsets.all(AppSpacing.xs),
              child: Icon(
                Icons.share_outlined,
                size: 22,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color color;
  final VoidCallback? onTap;
  final bool filled;

  const _ActionButton({
    required this.icon,
    required this.count,
    required this.color,
    this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xs,
          horizontal: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (filled)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 14, color: Colors.white),
              )
            else
              Icon(icon, size: 22, color: color),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '($count)',
              style: AppTextStyles.actionCount.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
