import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// ignore: must_be_immutable
class CustomDatePicker extends StatelessWidget {
  final String title;
  final String name;
  FormFieldValidator<DateTime>? validator;
  CustomDatePicker(
      {Key? key, required this.title, this.validator, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 20, bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(title),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 25,
              fontFamily: 'NotoSansLao',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FormBuilderDateTimePicker(
            name: name,
            inputType: InputType.date,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.only(
                left: 20,
                top: 10,
                bottom: 10,
                right: 10,
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
