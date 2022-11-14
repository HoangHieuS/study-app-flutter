import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/themes.dart';
import 'package:flutter_study_app/features/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class MenuDrawer extends GetView<HomeController> {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIParameters.mobileScreenPadding,
      width: double.maxFinite,
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Theme(
        data: ThemeData(
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(backgroundColor: onSurfaceTextColor)),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () => controller.toggleDrawer(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
