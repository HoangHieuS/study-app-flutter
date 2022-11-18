import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/themes.dart';

enum AnswerStatus {
  correct,
  incorrect,
  answered,
  notAnswered,
}

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;
  const AnswerCard({
    super.key,
    required this.answer,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: isSelected ? answerSelectedColor(context): Theme.of(context).cardColor,
          border: Border.all(
            color: isSelected ? answerSelectedColor(context) : answerBorderColor(),
          )
        ),
        child: Text(
          answer,
          style: TextStyle(
            color: isSelected ? onSurfaceTextColor : null,
          ),
        ),
      ),
    );
  }
}
