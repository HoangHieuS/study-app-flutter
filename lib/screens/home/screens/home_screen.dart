import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/themes.dart';
import 'package:flutter_study_app/controllers/controllers.dart';
import 'package:flutter_study_app/screens/screens.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionPaperController _quesitonController = Get.find();
    return Scaffold(
      body: Obx(
        () => ListView.separated(
          padding: UIParameters.mobileScreenPadding,
          itemBuilder: (context, index) {
            return QuestionCard(model: _quesitonController.allPapers[index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
          itemCount: _quesitonController.allPapers.length,
        ),
      ),
    );
  }
}
