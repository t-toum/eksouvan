import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/field_keys.dart';
import 'package:eksouvan/core/widgets/custom_textfield.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/utils/form_builder_validator.dart';
import '../cubit/setting_cubit.dart';
import '../cubit/setting_state.dart';

class AddUserModalWidget extends StatelessWidget {
  const AddUserModalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingCubit>();
    return BlocBuilder<SettingCubit, SettingState>(builder: (context, state) {
      if (state.dataStatus == DataStatus.loading) {
        return const LoadingWidget(showImage: false);
      }
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    AppNavigator.goBack();
                  },
                  child: Text(
                    LocaleKeys.kCancel.tr(),
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    cubit.createNewUser();
                  },
                  child: Text(
                    LocaleKeys.kOk.tr(),
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              LocaleKeys.kNewUser.tr(),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: FormBuilder(
                  key: cubit.formAddUserKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        name: FieldKeys.kName,
                        hintText: LocaleKeys.kUsername.tr(),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: LocaleKeys.kRequiredField.tr())
                        ]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        name: FieldKeys.kEmail,
                        hintText: LocaleKeys.kEmail.tr(),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: LocaleKeys.kRequiredField.tr())
                        ]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        name: FieldKeys.kPassword,
                        obscureText: true,
                        hintText: LocaleKeys.kPassword.tr(),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: LocaleKeys.kRequiredField.tr())
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      (state.dataStatus == DataStatus.failure)
                          ? Text(
                              state.error.toString(),
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.red),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      );
    });
  }
}
