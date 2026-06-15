import 'package:get/get.dart';
import 'package:inttask/data/models/comment_model.dart';
import 'package:inttask/data/models/post_model.dart';

class PostDetailsController extends GetxController {
  final Rx<PostModel?> post = Rx<PostModel?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPost();
  }

  void _loadPost() {
    final arguments = Get.arguments;
    if (arguments is PostModel) {
      post.value = arguments;
    }
  }

  int get commentCount => post.value?.commentCount ?? 0;
  List<CommentModel> get comments => post.value?.postComments ?? [];
  bool get hasComments => comments.isNotEmpty;
}
