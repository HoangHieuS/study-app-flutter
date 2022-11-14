import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/themes.dart';
import 'package:flutter_study_app/models/models.dart';
import 'package:flutter_study_app/features/home/widgets/custom_icon_text.dart';
import 'package:get/get.dart';

class QuestionCard extends StatelessWidget {
  final QuestionPaperModel model;
  const QuestionCard({
    super.key,
    required this.model,
  });

  void navigateToQuestionScreen() {
    Get.toNamed('/question', arguments: model);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double _padding = 10.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: InkWell(
        onTap: () {
          print('${model.title}');
        },
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      child: SizedBox(
                        height: size.width * 0.15,
                        width: size.width * 0.15,
                        child: CachedNetworkImage(
                          imageUrl: model.imageUrl!,
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/app_splash_logo.png'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: cartTitle(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(model.description),
                        ),
                        Row(
                          children: [
                            CustomIconText(
                              icon: Icon(Icons.help_outline_sharp,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor),
                              text: Text(
                                '${model.questionsCount} questions',
                                style: detailText.copyWith(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Theme.of(context).primaryColor),
                              ),
                            ),
                            const SizedBox(width: 15),
                            CustomIconText(
                              icon: Icon(Icons.timer,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor),
                              text: Text(
                                model.timeInMinutes(),
                                style: detailText.copyWith(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: -_padding,
                right: -_padding,
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(cardBorderRadius),
                        bottomRight: Radius.circular(cardBorderRadius),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    child: const Icon(AppIcons.trophyOutLine),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
