import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/themes.dart';
import 'package:flutter_study_app/models/models.dart';

class QuestionCard extends StatelessWidget {
  final QuestionPaperModel model;
  const QuestionCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double _padding = 10.0;
    return Padding(
      padding: const EdgeInsets.all(_padding),
      child: Stack(
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
                      style: TextStyle(
                        color: UIParameters.isDarkMode()
                            ? Theme.of(context).textTheme.bodyText1!.color
                            : Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: Text(model.description),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
