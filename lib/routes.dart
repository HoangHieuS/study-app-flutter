import 'package:flutter_study_app/controllers/controllers.dart';
import 'package:get/get.dart';

import 'features/home/controllers/home_controller.dart';
import 'features/features.dart';

class Routes {
  static List<GetPage> routes() => [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/introduction',
          page: () => const IntroductionScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          binding: BindingsBuilder(() {
            Get.put(QuestionPaperController());
            Get.put(HomeController());
          }),
        ),
      ];
}
