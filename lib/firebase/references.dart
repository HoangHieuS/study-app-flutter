import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;
final questionPaperRF = firestore.collection('questionPapers');
DocumentReference questionRF({
  required String questionPaperId,
  required String questionId,
}) =>
    questionPaperRF
        .doc(questionPaperId)
        .collection('questions')
        .doc(questionId);
