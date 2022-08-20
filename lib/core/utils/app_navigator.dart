import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AppNavigator {
  static GlobalKey<NavigatorState>? navigatorKey;

  static AppNavigator? _instance;
  AppNavigator._() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  factory AppNavigator() {
    _instance ??= AppNavigator._();
    return _instance!;
  }
  static void navigateTo(String routeName, {dynamic params}) {
    navigatorKey!.currentState?.pushNamed(routeName, arguments: params);
  }

  static void goBack() {
    navigatorKey!.currentState!.pop();
  }

  static void goBackUntil(String routeName) {
    navigatorKey!.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  static void pushAndRemoveUntil(String routeName, {dynamic params}) {
    navigatorKey!.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: params);
  }

  static void goBackWithData({dynamic data}) {
    navigatorKey!.currentState!.pop(data);
  }

  static navigateToWithData(String routeName, {dynamic params}) {
    return navigatorKey!.currentState?.pushNamed(routeName, arguments: params);
  }

  static openDialog({String? title, String? content, VoidCallback? onPressed}) {
    showCupertinoModalPopup(
      context: navigatorKey!.currentState!.context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title ?? ''),
          content: Text(content ?? ''),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(LocaleKeys.kCancel.tr()),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: onPressed,
              child: Text(LocaleKeys.kOk.tr()),
            )
          ],
        );
      },
    );
  }

  static openModel({required Widget chiled}) {
    showCupertinoModalBottomSheet(
      enableDrag: false,
      context: navigatorKey!.currentContext!,
      builder: ((_) => chiled),
    );
  }
}
