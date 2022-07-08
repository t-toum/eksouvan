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
  final bool resdOnly;
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
    this.resdOnly = false,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
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
            name: 'username',
            key: key,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusColor: AppColors.primaryColor,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              isDense: true,
              hintText: hintText,
            ),
            style: const TextStyle(
                fontSize: 20, fontFamily: 'NotoSansLao', color: Colors.black),
            validator: validator,
            onChanged: onChanged,
            initialValue: initialValue,
            enabled: enabled,
            readOnly: resdOnly,
          )
        ],
      ),
    );
  }
}
