import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_eco/utils/colors.dart';
import 'package:test_eco/utils/shared/page_navigator.dart';

bool isLoading = false;

const bgColorLoader = Color(0x0c8e8e8e);

const Dialog _alert = Dialog(
    backgroundColor: bgColorLoader,
    insetPadding: EdgeInsets.all(0),
    child: Center(
        child: CupertinoActivityIndicator(
      color: primaryColor,
      radius: 14,
    )));

loader({required BuildContext context}) {
  if (isLoading) {
    return;
  }

  isLoading = true;

  try {
    hideKeyboard;
  } catch (_) {
    debugPrint("ERRROR ON SNACKBAR");
  }

  try {
    showDialog(
      barrierDismissible: false,
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(statusBarColor: bgColorLoader),
            child: _alert,
          ),
        );
      },
    );
  } catch (e) {
    debugPrint("ERRROR ON POPUP:$e");
  }
}

hideLoader(BuildContext context) {
  if (isLoading) {
    isLoading = false;
    Screen.closeDialog(context);
  }
}

void get hideKeyboard => FocusManager.instance.primaryFocus?.unfocus();
