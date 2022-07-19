import 'package:eksouvan/core/utils/dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../utils/constants.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdwonItems> items;
  final String name;
  final FormFieldValidator<dynamic>? validator;
  final T? initialValue;
  final String? labelText;
  final bool enabled;
  final String? hintText;
  const CustomDropdown({
    Key? key,
    required this.items,
    this.initialValue,
    required this.name,
    this.validator,
    this.labelText,
    this.enabled = true,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (labelText == null)
              ? Container()
              : Text(
                  labelText!.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontFamily: 'NotoSansLao',
                    fontWeight: FontWeight.bold,
                  ),
                ),
          const SizedBox(
            height: 10,
          ),
          FormBuilderDropdown(
            enabled: enabled,
            name: name,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(8)),
            ),
            initialValue: initialValue,
            validator: validator,
            allowClear: true,
            hint: Text(hintText ?? ''),
            items: items
                .map((gender) => DropdownMenuItem(
                      value: gender.id,
                      child: Text('${gender.name}'),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
