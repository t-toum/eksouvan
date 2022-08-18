import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/core/widgets/custom_button.dart';
import 'package:eksouvan/core/widgets/custom_textfield.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/login/preesentation/cubit/login_cubit.dart';
import 'package:eksouvan/features/login/preesentation/cubit/login_state.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/utils/form_builder_validator.dart';
import '../../../../core/widgets/widget_builder.dart';
import '../widgets/branner_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.dataStatus == DataStatus.failure) {
                WidgetBuilders.customDialog(
                    title: LocaleKeys.kLoginLabel.tr(),
                    context: context,
                    content: state.error ?? '');
              } else if (state.dataStatus == DataStatus.success) {
                if (state.uid != null || state.uid == '') {
                  AppNavigator.pushAndRemoveUntil(AppRoute.homeRoute);
                }
              }
            },
            builder: (context, state) {
              if (state.dataStatus == DataStatus.loading) {
                return const LoadingWidget();
              } else {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const BrannerWidget(),
                      Container(
                        padding: const EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          LocaleKeys.kLoginLabel.tr(),
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSansLao',
                          ),
                        ),
                      ),
                      //Form Login
                      FormBuilder(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              controller: emailController,
                              name: 'Username',
                              // hintText: 'Input your username',
                              labelText: LocaleKeys.kUsernameLabel.tr(),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: LocaleKeys.kRequiredField.tr())
                              ]),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                              name: 'password',
                              // hintText: 'Input your Password',
                              obscureText: true,
                              controller: passwordController,
                              labelText: LocaleKeys.kPasswordLabel.tr(),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: LocaleKeys.kRequiredField.tr())
                              ]),
                            ),
                          ],
                        ),
                      ),
                      CusttomButton(
                        onPressed: () {
                          final String email = emailController.text;
                          if (_formKey.currentState!.saveAndValidate()) {
                            context.read<LoginCubit>().login(
                                email: email,
                                password: passwordController.text);
                          } else {
                            print("validation failed");
                          }
                        },
                        title: LocaleKeys.kLoginLabel.tr(),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
