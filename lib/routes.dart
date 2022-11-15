import 'package:flutter_study_app/controllers/controllers.dart';
import 'package:flutter_study_app/features/auth/screens/login_screen.dart';
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
          name: HomeScreen.routeName,
          page: () => const HomeScreen(),
          binding: BindingsBuilder(() {
            Get.put(QuizPaperController());
            Get.put(HomeController());
          }),
        ),
         GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
      ];
}
