import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study_app/firebase/loading_status.dart';
import 'package:flutter_study_app/models/models.dart';
import 'package:get/get.dart';

import '../../firebase/references.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading;

    final firestore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith('assets/DB/papers') && path.contains('.json'))
        .toList();
    List<QuestionPaperModel> questionPapers = [];
    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPapers
          .add(QuestionPaperModel.fromJson(jsonDecode(stringPaperContent)));
    }

    var batch = firestore.batch();

    for (var paper in questionPapers) {
      var ref = questionPaperRF.doc(paper.id);
      batch.set(ref, {
        'title': paper.title,
        'image_url': paper.imageUrl,
        'description': paper.description,
        'time_seconds': paper.timeSeconds,
        'questions_count':
            paper.questions == null ? 0 : paper.questions!.length,
      });

      for (var questions in paper.questions!) {
        final questionPath = questionRF(
          questionPaperId: paper.id,
          questionId: questions.id,
        );
        batch.set(questionPath, {
          'question': questions.question,
          'corret_answer': questions.correctAnswer,
        });

        for (var answer in questions.answers) {
          batch.set(questionPath.collection('ansers').doc(answer.identifier), {
            'identifier': answer.identifier,
            'answer': answer.answer,
          });
        }
      }
    }

    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}
