import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final void Function(dynamic)? onChanged;
  final String? initialValue;
  final bool enabled;
  final bool readOnly;
  final String name;
  const CustomTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.initialValue,
    this.readOnly = false,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (labelText == null)
              ? Container()
              : Text(
                  tr(labelText!).toUpperCase(),
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
          FormBuilderTextField(
            obscureText: obscureText,
            controller: controller,
            name: name,
            key: key,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(18),
              ),
              focusColor: AppColors.primaryColor,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(18),
              ),
              isDense: true,
              hintText: hintText,
              contentPadding: const EdgeInsets.only(
                left: 20,
                top: 10,
                bottom: 10,
                right: 10,
              ),
            ),
            style: const TextStyle(
                fontSize: 18, fontFamily: 'NotoSansLao', color: Colors.black),
            validator: validator,
            onChanged: onChanged,
            initialValue: initialValue,
            enabled: enabled,
            readOnly: readOnly,
          )
        ],
      ),
    );
  }
}
