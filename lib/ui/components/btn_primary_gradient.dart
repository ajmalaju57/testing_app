import 'package:flutter/material.dart';
import 'package:test_eco/ui/components/app_text.dart';
import 'package:test_eco/utils/colors.dart';
import 'package:test_eco/utils/extensions/string_ext.dart';
import 'package:test_eco/utils/strings.dart';

class BtnPrimaryGradient extends StatelessWidget {
  const BtnPrimaryGradient({
    Key? key,
    required this.onTap,
    required this.text,
    this.family = inter600,
    this.fontSize = 14,
    this.textColor = colorWhite,
    this.bgColor,
    this.padding,
    this.width,
    this.borderColor,
    this.borderRadius = 8,
    this.height = 48,
    this.isOnlyRadius = false,
    this.isOnlyRadiusSize = 9,
  }) : super(key: key);

  final void Function() onTap;
  final String text;
  final EdgeInsets? padding;
  final double? width, fontSize, height, borderRadius, isOnlyRadiusSize;
  final String? family;
  final Color textColor;
  final Color? bgColor, borderColor;
  final bool isOnlyRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          height: height!,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? primaryColor),
            color: bgColor,
            // gradient: bgColor == null ? primaryGradient : null,
            borderRadius: isOnlyRadius
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(isOnlyRadiusSize!),
                  )
                : BorderRadius.circular(borderRadius!),
          ),
          child: AppText(text.upperFirst,
              family: family, color: textColor, size: fontSize)),
    );
  }
}
