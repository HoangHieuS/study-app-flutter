import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/themes.dart';

const Color onSurfaceTextColor = Colors.white;
const Color correctAnswerColor = Color(0xFF3AC3CB);
const Color incorrectAnswerColor = Color(0xFFF85187);
const Color notAnsweredColor = Color(0xFF2A3C65);

const mainGradientLight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    primaryLightColorLight,
    primaryColorLight,
  ],
);

const mainGradientDark = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    primaryDarkColorDark,
    primaryColorDark,
  ],
);

LinearGradient mainGradient() =>
    UIParameters.isDarkMode() ? mainGradientDark : mainGradientLight;

Color customScaffoldColor(BuildContext context) => UIParameters.isDarkMode()
    ? const Color(0xFF2E3C62)
    : const Color.fromARGB(255, 248, 237, 255);

Color answerSelectedColor(BuildContext context) => UIParameters.isDarkMode()
    ? Theme.of(context).cardColor.withOpacity(0.5)
    : Theme.of(context).primaryColor;

Color answerBorderColor() => UIParameters.isDarkMode()
    ? const Color.fromARGB(255, 20, 46, 158)
    : const Color.fromARGB(255, 221, 221, 221);
