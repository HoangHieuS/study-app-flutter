import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/custom_text_style.dart';
import 'package:flutter_study_app/core/commom/custom_bg.dart';
import 'package:flutter_study_app/features/features.dart';
import 'package:flutter_study_app/features/home/widgets/content_area.dart';
import 'package:flutter_study_app/features/question/controller/question_controller.dart';
import 'package:flutter_study_app/features/question/widgets/answer_card.dart';
import 'package:flutter_study_app/features/question/widgets/custom_app_bar.dart';
import 'package:get/get.dart';

class AnswerCheckScreen extends GetView<QuestionController> {
  static const String routeName = '/answer-check';
  const AnswerCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            'Q. ${(controller.questionIndex.value).toString().padLeft(2, '0')}',
            style: appBarText,
          ),
        ),
        showActionIcon: true,
        onMenuActionTap: () => Get.toNamed(ResultScreen.routeName),
      ),
      body: CustomBackground(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: ContentArea(
                    child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        controller.currentQuestion.value!.question,
                        style: questionText,
                      ),
                      GetBuilder<QuestionController>(
                        id: 'answer_review_list',
                        builder: (_) {
                          return ListView.separated(
                            padding: const EdgeInsets.only(top: 25),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final answer = controller
                                  .currentQuestion.value!.answers[index];
                              final selectedAnswer = controller
                                  .currentQuestion.value!.selectedAnswer;
                              final correctAnswer = controller
                                  .currentQuestion.value!.correctAnswer;
                              final String answerText =
                                  '${answer.identifier}. ${answer.answer}';

                              if (correctAnswer == selectedAnswer &&
                                  answer.identifier == selectedAnswer) {
                                return CorrectAnswer(answer: answerText);
                              } else if (selectedAnswer == null) {
                                return NotAnswered(answer: answerText);
                              } else if (correctAnswer != selectedAnswer &&
                                  answer.identifier == selectedAnswer) {
                                return InCorrectAnswer(answer: answerText);
                              } else if (correctAnswer == answer.identifier) {
                                return CorrectAnswer(answer: answerText);
                              }

                              return AnswerCard(
                                answer: answerText,
                                onTap: () {},
                                isSelected: false,
                              );
                            },
                            separatorBuilder: (_, i) =>
                                const SizedBox(height: 10),
                            itemCount: controller
                                .currentQuestion.value!.answers.length,
                          );
                        },
                      ),
                    ],
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
