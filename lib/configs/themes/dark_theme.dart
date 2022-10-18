import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/sub_theme_data_mixin.dart';

const Color primaryDarkColorDark = Color(0xFF2E3C62);
const Color primaryColorDark = Color(0xFF99ACE1);
const Color mainTextColorDark = Colors.white;


class DarkTheme with SubThemeData {
  ThemeData buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
      primaryColor: primaryColorDark,
      iconTheme: getIconTheme(),
      textTheme: getTextTheme().apply(
        bodyColor: mainTextColorDark,
        displayColor: mainTextColorDark,
      )
    );
  }
}
