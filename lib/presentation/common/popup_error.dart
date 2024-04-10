import 'dart:ui';

import 'package:chapt/presentation/resources/app_strings.dart';
import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:chapt/presentation/widgets/button.dart';
import 'package:flutter/material.dart';

class PopupError {
  static void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: AppValues.v10, sigmaY: AppValues.v10),
          child: Dialog(
            backgroundColor:
                Theme.of(context).primaryColor.withOpacity(AppValues.v025),
            elevation: AppValues.v05,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning_rounded,
                    size: AppValues.v50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: Text(errorMessage),
                  ),
                  AppButton(
                      content: const Text(AppStrings.cont),
                      action: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
