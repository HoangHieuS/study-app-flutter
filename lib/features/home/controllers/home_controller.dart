import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();

  @override
  void onReady() {
    
    super.onReady();
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {}

  void signIn() {}

  void website() {}

  void email() {
    final Uri emailLaunchUri = Uri(scheme: 'mailto', path: 'info@gmail.com');
    _launchUrl(emailLaunchUri);
  }

  Future<void> _launchUrl(Uri url) async {  
    if (!await launchUrl(url))  {
      throw 'Could not launch $url';
    }
  }
}
