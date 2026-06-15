import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inttask/app/constants/app_strings.dart';
import 'package:inttask/app/routes/app_pages.dart';
import 'package:inttask/app/theme/app_theme.dart';
import 'package:inttask/data/repositories/post_repository.dart';
import 'package:inttask/data/services/api_service.dart';
import 'package:inttask/modules/feed/binding/feed_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  _initDependencies();

  runApp(const SocialFeedApp());
}

void _initDependencies() {
  Get.put<ApiService>(ApiService(), permanent: true);
  Get.put<PostRepository>(
    PostRepository(apiService: Get.find<ApiService>()),
    permanent: true,
  );
}

class SocialFeedApp extends StatelessWidget {
  const SocialFeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: FeedBinding(),
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
