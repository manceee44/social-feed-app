import 'package:flutter/material.dart';
import 'package:inttask/app/theme/app_spacing.dart';
import 'package:inttask/widgets/common/app_network_image.dart';

class PostImage extends StatelessWidget {
  final String? imageUrl;
  final double? aspectRatio;

  const PostImage({
    super.key,
    this.imageUrl,
    this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.imageRadius),
      child: AspectRatio(
        aspectRatio: aspectRatio ?? 4 / 3,
        child: AppNetworkImage(
          imageUrl: imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
          borderRadius: AppSpacing.imageRadius,
        ),
      ),
    );
  }
}
