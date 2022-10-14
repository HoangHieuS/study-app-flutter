import 'package:flutter/material.dart';
import 'package:flutter_study_app/controllers/controllers.dart';
import 'package:flutter_study_app/firebase/loading_status.dart';
import 'package:get/get.dart';

class DataUploadScreen extends StatelessWidget {
  DataUploadScreen({super.key});
  DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text(
            controller.loadingStatus.value == LoadingStatus.completed
                ? 'Uploading completed'
                : 'Uploading...'),),
      ),
    );
  }
}
