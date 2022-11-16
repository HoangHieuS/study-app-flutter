import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_study_app/controllers/controllers.dart';
import 'package:flutter_study_app/models/models.dart';
import 'package:flutter_study_app/services/firebase_service.dart';
import 'package:get/get.dart';

import '../../features/question/screens/question_screen.dart';
import '../../firebase/references.dart';

class QuizPaperController extends GetxController {
  final allPapers = <QuestionPaperModel>[].obs;

  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = ['biology', 'chemistry', 'maths', 'physics'];
    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();
      allPapers.assignAll(paperList);

      for (var paper in paperList) {
        final imgUrl = await Get.find<FirebaseService>().getImage(paper.title);
        paper.imageUrl = imgUrl;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      print(e);
    }
  }

  void navigateToQuestions({
    required QuestionPaperModel paper,
    bool tryAgain = false,
  }) {
    AuthController _authController = Get.find();
    if (_authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
        //Get.offNamed(page);
      } else {
        Get.toNamed(QuestionScreen.routeName, arguments: paper);
      }
    } else {
      _authController.showLoginAleartDialogue();
    }
  }
}
