import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_study_app/features/question/controller/question_controller.dart';
import 'package:get/get.dart';

import '../../../firebase/references.dart';
import '../../auth/controllers/auth_controller.dart';

extension QuestionControllerExtension on QuestionController {
  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestion {
    return '$correctQuestionCount out of ${allQuestions.length} are correct';
  }

  String get points {
    var points = (correctQuestionCount / allQuestions.length) *
        100 *
        (questionPaperModel.timeSeconds - remainSeconds) /
        questionPaperModel.timeSeconds *
        100;
    return points.toStringAsFixed(2);
  }

  Future<void> saveTestResults() async {
    var batch = firestore.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null) return;
    batch.set(
      userRF
          .doc(_user.email)
          .collection('testResults')
          .doc(questionPaperModel.id),
      {
        'points': points,
        'corect_answer': '$correctQuestionCount/${allQuestions.length}',
        'question_id': questionPaperModel.id,
        'time': questionPaperModel.timeSeconds - remainSeconds,
      },
    );
    batch.commit();
    navigateToHome();
  }
}
