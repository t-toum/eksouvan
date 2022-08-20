import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_cubit.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/setting_state.dart';

class ModalWidget extends StatelessWidget {
  final bool isUpdate;
  final VoidCallback? onSave;
  final String? title;
  final Widget? body;

  const ModalWidget({
    Key? key,
    this.isUpdate = false,
    this.onSave,
    this.title,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(builder: ((context, state) {
      return Scaffold(
        body: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        AppNavigator.goBackWithData();
                      },
                      child: Text(
                        LocaleKeys.kCancel.tr(),
                        style: const TextStyle(
                            color: AppColors.primaryColor, fontSize: 20),
                      ),
                    ),
                    Text(title ?? ""),
                    (onSave == null)
                        ? const SizedBox()
                        : TextButton(
                            onPressed: onSave,
                            child: Text(
                              LocaleKeys.kOk.tr(),
                              style: const TextStyle(
                                  color: AppColors.primaryColor, fontSize: 20),
                            ),
                          )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: body,
              ),
            )),
          ],
        ),
      );
    }));
  }
}
