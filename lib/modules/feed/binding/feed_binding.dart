import 'package:get/get.dart';
import 'package:inttask/data/services/api_service.dart';
import 'package:inttask/data/repositories/post_repository.dart';
import 'package:inttask/modules/feed/controller/feed_controller.dart';

class FeedBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ApiService>()) {
      Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    }
    if (!Get.isRegistered<PostRepository>()) {
      Get.lazyPut<PostRepository>(
        () => PostRepository(apiService: Get.find<ApiService>()),
        fenix: true,
      );
    }
    Get.lazyPut<FeedController>(
      () => FeedController(postRepository: Get.find<PostRepository>()),
    );
  }
}
