import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/custom_text_style.dart';
import 'package:flutter_study_app/configs/themes/themes.dart';
import 'package:flutter_study_app/core/commom/custom_bg.dart';
import 'package:flutter_study_app/core/commom/main_button.dart';
import 'package:flutter_study_app/features/home/widgets/content_area.dart';
import 'package:flutter_study_app/features/question/controller/question_controller.dart';
import 'package:flutter_study_app/features/question/widgets/answer_card.dart';
import 'package:get/get.dart';

import '../../../firebase/loading_status.dart';
import '../widgets/question_screen_holder.dart';

class QuestionScreen extends GetView<QuestionController> {
  static const String routeName = '/question-screen';
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Obx(
          () => Column(
            children: [
              if (controller.loadingStatus.value == LoadingStatus.loading)
                const Expanded(
                  child: ContentArea(
                    child: QuestionScreenHolder(),
                  ),
                ),
              if (controller.loadingStatus.value == LoadingStatus.completed)
                Expanded(
                  child: ContentArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          Text(
                            controller.currentQuestion.value!.question,
                            style: questionText,
                          ),
                          GetBuilder<QuestionController>(
                            id: 'answers_list',
                            builder: (context) {
                              return ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 25),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final answer = controller
                                      .currentQuestion.value!.answers[index];
                                  return AnswerCard(
                                    answer:
                                        '${answer.identifier}. ${answer.answer}',
                                    onTap: () {
                                      controller
                                          .selectedAnswer(answer.identifier);
                                    },
                                    isSelected: answer.identifier ==
                                        controller.currentQuestion.value!
                                            .selectedAnswer,
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
                    ),
                  ),
                ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: Row(
                    children: [
                      Visibility(
                        visible: controller.isFirstQuestion,
                        child: SizedBox(
                          width: 55,
                          height: 55,
                          child: MainButton(
                            onTap: () => controller.prevQuestion(),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Get.isDarkMode
                                  ? onSurfaceTextColor
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Visibility(
                          visible: controller.loadingStatus.value ==
                              LoadingStatus.completed,
                          child: MainButton(
                            onTap: () => controller.isLastQuestion
                                ? Container()
                                : controller.nextQuestion(),
                            title:
                                controller.isLastQuestion ? 'Complete' : 'Next',
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
      ),
    );
  }
}
