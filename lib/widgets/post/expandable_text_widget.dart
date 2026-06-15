import 'package:flutter/material.dart';
import 'package:inttask/app/constants/app_strings.dart';
import 'package:inttask/app/theme/app_text_styles.dart';
import 'package:readmore/readmore.dart';

class ExpandableTextWidget extends StatelessWidget {
  final String text;
  final int trimLines;
  final bool useSerifFont;
  final bool expandable;

  const ExpandableTextWidget({
    super.key,
    required this.text,
    this.trimLines = 2,
    this.useSerifFont = false,
    this.expandable = true,
  });

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return Text(
        AppStrings.noContent,
        style: AppTextStyles.metadata,
      );
    }

    if (!expandable) {
      return Text(
        text,
        style: useSerifFont ? AppTextStyles.bodySerif : AppTextStyles.body,
      );
    }

    return ReadMoreText(
      text,
      trimLines: trimLines,
      trimMode: TrimMode.Line,
      trimCollapsedText: ' ${AppStrings.readMore}',
      trimExpandedText: ' ${AppStrings.readLess}',
      moreStyle: AppTextStyles.readMore,
      lessStyle: AppTextStyles.readMore,
      style: useSerifFont ? AppTextStyles.bodySerif : AppTextStyles.body,
      textAlign: TextAlign.start,
    );
  }
}
