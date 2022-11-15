import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/themes.dart';
import 'package:flutter_study_app/controllers/question_papers/quiz_paper_controller.dart';
import 'package:flutter_study_app/features/home/widgets/content_area.dart';
import 'package:flutter_study_app/features/features.dart';
import 'package:flutter_study_app/core/circle_button.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_study_app/features/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';

class HomeScreen extends GetView<HomeController> {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuizPaperController quesitonController = Get.find();
    final user = Get.find<AuthController>().getUser();
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (_) {
          return ZoomDrawer(
            borderRadius: 50,
            controller: _.zoomDrawerController,
            showShadow: true,
            angle: 0.0,
            style: DrawerStyle.DefaultStyle,
            backgroundColor: Colors.white.withOpacity(0.5),
            // menuBackgroundColor: const Color(0xFF3AC3CB),
            slideWidth: MediaQuery.of(context).size.width * 0.6,
            menuScreen: const MenuDrawer(),
            mainScreen: Container(
              decoration: BoxDecoration(
                gradient: mainGradient(),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(mobileScreenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleButton(
                            onTap: controller.toggleDrawer,
                            child: const Icon(AppIcons.menuLeft),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const Icon(AppIcons.peace),
                                Text(
                                  user != null ? 'Hello ${user.displayName}': 'Hello Friend',
                                  style: detailText.copyWith(
                                      color: onSurfaceTextColor),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'What do you want to learn today?',
                            style: headerText,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ContentArea(
                          addPadding: false,
                          child: Obx(
                            () => ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              itemCount: quesitonController.allPapers.length,
                              itemBuilder: (context, index) {
                                return QuestionCard(
                                    model: quesitonController.allPapers[index]);
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 20);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
