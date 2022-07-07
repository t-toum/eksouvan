import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Center(
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
                          labelText: 'kUsernameLabel',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: tr("kRequiredField"))
                          ]),
                        ),
                        CustomTextField(
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
                    onPressed: () async {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        print(_formKey.currentState!.value);
                        print(emailController.text);
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          print(credential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
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
            ),
          ),
        ),
      ),
    );
  }
}
