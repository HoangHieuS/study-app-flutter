import 'package:flutter/material.dart';
import 'package:flutter_study_app/core/commom/custom_bg.dart';
import 'package:flutter_study_app/features/question/controller/question_controller.dart';
import 'package:get/get.dart';

class QuestionScreen extends GetView<QuestionController> {
  static const String routeName = '/question-screen';
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomBackground(
        child: Center(child: Text('I am here'),),
      ),
    );
  }
}
