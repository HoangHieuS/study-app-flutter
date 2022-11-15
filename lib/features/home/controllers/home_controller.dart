import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_study_app/controllers/controllers.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user = Rxn();

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {}

  void github() {
    _launchUrl('https://github.com/HoangHieuS');
  }

  void facebook() {
    _launchUrl('https://github.com/HoangHieuS');
  }

  void email() {
    final Uri emailLaunchUri = Uri(scheme: 'mailto', path: 'info@gmail.com');
    _launchUrl(emailLaunchUri.toString());
  }

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }
}
