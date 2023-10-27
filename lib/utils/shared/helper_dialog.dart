import 'dart:ui';

import 'package:flutter/material.dart';

Future showPopup(BuildContext context,
    {required Widget content, bool barrierDismissible = true}) {
  return showDialog(
      barrierColor: Colors.black.withOpacity(0.8),
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            content: content,
            backgroundColor: Colors.transparent,
          ),
        );
      });
}
