import 'package:inttask/app/constants/api_constants.dart';
import 'package:inttask/app/constants/app_strings.dart';
import 'package:inttask/data/models/post_model.dart';
import 'package:inttask/data/services/api_service.dart';

class PostRepository {
  final ApiService _apiService;

  PostRepository({required ApiService apiService}) : _apiService = apiService;

  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await _apiService.get(ApiConstants.baseUrl);

      if (response == null) {
        throw const ApiException(AppStrings.noDataError);
      }

      if (response is! List) {
        throw const ApiException(AppStrings.genericError);
      }

      if (response.isEmpty) {
        return [];
      }

      return response
          .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('${AppStrings.genericError} ($e)');
    }
  }

  Future<PostModel?> fetchPostById(String postId) async {
    final posts = await fetchPosts();
    try {
      return posts.firstWhere((post) => post.postId == postId);
    } catch (_) {
      return null;
    }
  }
}
