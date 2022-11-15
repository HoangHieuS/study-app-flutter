import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/colors.dart';

class MainButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool enable;
  final Widget? child;
  final Color? color;
  const MainButton({
    Key? key,
    this.title = '',
    required this.onTap,
    this.enable = true,
    this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: 55,
        child: InkWell(
          onTap: enable ? onTap : null,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color ?? Theme.of(context).cardColor,
            ),
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: child ??
                  Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: onSurfaceTextColor,
                      ),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
