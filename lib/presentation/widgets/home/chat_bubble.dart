import 'package:chapt/app/app_constants.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class AppChatBubble extends StatelessWidget {
  final Message message;
  const AppChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.role == AppConstants.modelRoleName
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p10, vertical: AppPadding.p5),
        margin: EdgeInsets.only(
          bottom: AppPadding.p5,
          right: message.role == AppConstants.modelRoleName
              ? AppMargins.m40
              : AppPadding.p10,
          left: message.role == AppConstants.modelRoleName
              ? AppPadding.p10
              : AppMargins.m40,
        ),
        decoration: BoxDecoration(
          color: message.role == AppConstants.modelRoleName
              ? Theme.of(context).cardColor
              : Theme.of(context).colorScheme.primary,
          borderRadius: message.role == AppConstants.modelRoleName
              ? const BorderRadius.only(
                  bottomRight: Radius.circular(AppValues.v10),
                  topRight: Radius.circular(AppValues.v10),
                  topLeft: Radius.circular(AppValues.v10),
                )
              : const BorderRadius.only(
                  bottomLeft: Radius.circular(AppValues.v10),
                  topRight: Radius.circular(AppValues.v10),
                  topLeft: Radius.circular(AppValues.v10),
                ),
        ),
        child: Text(message.msg),
      ),
    );
  }
}
