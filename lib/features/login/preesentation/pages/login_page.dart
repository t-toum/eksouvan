import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/core/widgets/custom_textfield.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/login/preesentation/cubit/login_cubit.dart';
import 'package:eksouvan/features/login/preesentation/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/utils/form_builder_validator.dart';
import '../widgets/branner_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? _errorMessage;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.dataStatus == DataStatus.failure) {
                  _errorMessage = state.error;
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Login failed'),
                          content: Text(state.error ?? ''),
                          actions: [
                            TextButton(
                                onPressed: () => AppNavigator.goBack(),
                                child: const Text('OK'))
                          ],
                        );
                      });
                } else if (state.dataStatus == DataStatus.success) {
                  AppNavigator.pushAndRemoveUntil(AppRoute.homeRoute);
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
                            tr("kLoginLabel"),
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
                                key: const Key("Username"),
                                name: 'Username',
                                labelText: 'kUsernameLabel',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: tr("kRequiredField"))
                                ]),
                              ),
                              CustomTextField(
                                name: 'Password',
                                key: const Key('Password'),
                                obscureText: true,
                                controller: passwordController,
                                labelText: 'kPasswordLabel',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: tr("kRequiredField"))
                                ]),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.saveAndValidate()) {
                              context.read<LoginCubit>().login(
                                  email: emailController.text + '@eksouvan.com',
                                  password: passwordController.text);
                            } else {
                              print("validation failed");
                            }
                          },
                          child: Text(
                            tr("kLoginLabel"),
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
