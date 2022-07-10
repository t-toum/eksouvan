import 'package:eksouvan/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/widgets/app_template.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_date_picker.dart';

class RegisterPatientPage extends StatelessWidget {
  const RegisterPatientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      titleKey: "kNewRegisterLabel",
      body: Center(
        child: Column(
          children: [
            //Form Input
            FormBuilder(
              child: Column(
                children: [
                  const CustomTextField(name: 'Name', labelText: "kNameLabel"),
                  const CustomTextField(
                      name: 'Surname', labelText: "kLastName"),
                  const CustomDatePicker(
                    title: "kDateOfBirth",
                  ),
                  const CustomTextField(name: 'Tel', labelText: "kPhone"),
                  const CustomTextField(
                      name: 'address', labelText: "kCurrentAddress"),
                  CusttomButton(
                    title: 'kNewRegisterLabel',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
