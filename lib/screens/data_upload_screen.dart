import 'package:flutter/material.dart';
import 'package:flutter_study_app/controllers/controllers.dart';
import 'package:get/get.dart';

@im
class DataUploadScreen extends StatelessWidget {
  DataUploadScreen({super.key});
  DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Uploading'),
      ),
    );
  }
}