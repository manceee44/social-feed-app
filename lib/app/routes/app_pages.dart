import 'package:get/get.dart';
import 'package:inttask/app/routes/app_routes.dart';
import 'package:inttask/modules/feed/binding/feed_binding.dart';
import 'package:inttask/modules/feed/view/feed_view.dart';
import 'package:inttask/modules/post_details/binding/post_details_binding.dart';
import 'package:inttask/modules/post_details/view/post_details_view.dart';

abstract final class AppPages {
  static const initial = AppRoutes.feed;

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.feed,
      page: () => const FeedView(),
      binding: FeedBinding(),
    ),
    GetPage(
      name: AppRoutes.postDetails,
      page: () => const PostDetailsView(),
      binding: PostDetailsBinding(),
    ),
  ];
}
