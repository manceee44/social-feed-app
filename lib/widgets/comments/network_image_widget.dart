import 'package:flutter/material.dart';
import 'package:inttask/widgets/common/app_network_image.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double? size;
  final BoxFit fit;
  final double borderRadius;
  final bool isCircular;

  const NetworkImageWidget({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.size,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppNetworkImage(
      imageUrl: imageUrl,
      width: size ?? width,
      height: size ?? height,
      fit: fit,
      borderRadius: borderRadius,
      isCircular: isCircular,
    );
  }
}
