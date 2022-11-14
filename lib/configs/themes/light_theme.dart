import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/themes.dart';

const Color primaryLightColorLight = Color(0xFF3AC3CB);
const Color primaryColorLight = Color(0xFFF85187);
const Color mainTextColorLight = Color.fromARGB(255, 40, 40, 40);
const Color cardColor = Color.fromARGB(255, 254, 254, 255);

class LightTheme with SubThemeData {
  buildLightTheme() {
    final ThemeData systemLigthTheme = ThemeData.light();
    return systemLigthTheme.copyWith(
      primaryColor: primaryColorLight,
      iconTheme: getIconTheme(),
      cardColor: cardColor,
      textTheme: getTextTheme().apply(
        bodyColor: mainTextColorLight,
        displayColor: mainTextColorLight,
      ),
    );
  }
}
