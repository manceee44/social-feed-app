import 'package:get/get.dart';
import 'package:inttask/app/constants/app_strings.dart';
import 'package:inttask/data/models/post_model.dart';
import 'package:inttask/data/repositories/post_repository.dart';
import 'package:inttask/data/services/api_service.dart';

class FeedController extends GetxController {
  final PostRepository _postRepository;

  FeedController({required PostRepository postRepository})
      : _postRepository = postRepository;

  final RxList<PostModel> posts = <PostModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    try {
      final result = await _postRepository.fetchPosts();
      posts.assignAll(result);
    } on ApiException catch (e) {
      hasError.value = true;
      errorMessage.value = e.message;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = AppStrings.genericError;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPosts() async {
    await fetchPosts();
  }

  bool get isEmpty => !isLoading.value && !hasError.value && posts.isEmpty;
}
