import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/custom_text_style.dart';
import 'package:flutter_study_app/configs/themes/themes.dart';
import 'package:flutter_study_app/core/commom/custom_bg.dart';
import 'package:flutter_study_app/core/commom/main_button.dart';
import 'package:flutter_study_app/features/features.dart';
import 'package:flutter_study_app/features/home/widgets/content_area.dart';
import 'package:flutter_study_app/features/question/controller/question_controller.dart';
import 'package:flutter_study_app/features/question/controller/question_controller_extension.dart';
import 'package:flutter_study_app/features/question/widgets/answer_card.dart';
import 'package:flutter_study_app/features/question/widgets/custom_app_bar.dart';
import 'package:flutter_study_app/features/question/widgets/question_number_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ResultScreen extends GetView<QuestionController> {
  static const String routeName = '/result';
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color _textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: const SizedBox(height: 80),
        title: controller.correctAnsweredQuestion,
      ),
      body: CustomBackground(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/bulb.svg'),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        'Congratulation',
                        style: headerText.copyWith(color: _textColor),
                      ),
                    ),
                    Text(
                      'You have ${controller.points} points',
                      style: TextStyle(color: _textColor),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Tap below question numbers to view correct answer',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          final _question = controller.allQuestions[index];
                          AnswerStatus _status = AnswerStatus.notAnswered;
                          final _selectedAnswer = _question.selectedAnswer;
                          final _correctAnswer = _question.correctAnswer;
                          if (_selectedAnswer == _correctAnswer) {
                            _status = AnswerStatus.correct;
                          } else if (_selectedAnswer == null) {
                            _status = AnswerStatus.incorrect;
                          } else {
                            _status = AnswerStatus.incorrect;
                          }
                          return QuestionNumberCard(
                            index: index + 1,
                            status: _status,
                            onTap: () {
                              controller.jumpToQuestion(
                                index,
                                isGoback: false,
                              );
                              Get.toNamed(AnswerCheckScreen.routeName);
                            },
                          );
                        },
                        itemCount: controller.allQuestions.length,
                      ),
                    ),
                    ColoredBox(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding: UIParameters.mobileScreenPadding,
                        child: Row(
                          children: [
                            Expanded(
                              child: MainButton(
                                onTap: () => controller.tryAgain(),
                                color: Colors.blueGrey,
                                title: 'Try again',
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: MainButton(
                                onTap: () => controller.saveTestResults(),
                                title: 'Go home',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
