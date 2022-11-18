import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/themes.dart';
import 'package:flutter_study_app/core/commom/custom_bg.dart';
import 'package:flutter_study_app/core/commom/main_button.dart';
import 'package:flutter_study_app/features/home/widgets/content_area.dart';
import 'package:flutter_study_app/features/question/controller/question_controller.dart';
import 'package:flutter_study_app/features/question/widgets/question_number_card.dart';
import 'package:flutter_study_app/features/question/widgets/widgets.dart';
import 'package:get/get.dart';

class TestOverviewScreen extends GetView<QuestionController> {
  static const String routeName = '/test-overview';
  const TestOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completedTest,
      ),
      body: CustomBackground(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CountdownTimer(
                          time: '',
                          color: UIParameters.isDarkMode()
                              ? Theme.of(context).textTheme.bodyText1!.color
                              : Theme.of(context).primaryColor,
                        ),
                        Obx(
                          () => Text(
                            '${controller.time} Remaining',
                            style: countdownTimerText(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.allQuestions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          AnswerStatus? _answerStatus;
                          if (controller.allQuestions[index].selectedAnswer !=
                              null) {
                            _answerStatus = AnswerStatus.answered;
                          }

                          return QuestionNumberCard(
                            index: index + 1,
                            status: _answerStatus,
                            onTap: () => controller.jumpToQuestion(index),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: MainButton(
                  onTap: () => controller.complete(),
                  title: 'Complete',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
