import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomCheckBox extends FormBuilderField<bool> {
  final Widget title;
  final Widget? subtitle;
  final Widget? secondary;
  final Color? activeColor;
  final Color? checkColor;
  final ListTileControlAffinity controlAffinity;
  final EdgeInsets contentPadding;
  final bool autofocus;
  final bool shouldRequestFocus;
  final bool tristate;
  final bool selected;

  CustomCheckBox({
    Key? key,
    required String name,
    FormFieldValidator<bool>? validator,
    bool? initialValue,
    InputDecoration decoration = const InputDecoration(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    ),
    ValueChanged<bool?>? onChanged,
    ValueTransformer<bool?>? valueTransformer,
    bool enabled = true,
    FormFieldSetter<bool?>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback? onReset,
    FocusNode? focusNode,
    required this.title,
    this.activeColor,
    this.autofocus = false,
    this.checkColor,
    this.contentPadding = EdgeInsets.zero,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.secondary,
    this.selected = false,
    this.shouldRequestFocus = false,
    this.subtitle,
    this.tristate = false,
  }) : super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState<bool?> field) {
            final state = field as _CustomCheckBoxState;

            return InputDecorator(
              decoration: state.decoration,
              child: CheckboxListTile(
                dense: true,
                isThreeLine: false,
                title: title,
                subtitle: subtitle,
                value: tristate ? state.value : (state.value ?? false),
                onChanged: state.enabled
                    ? (value) {
                        if (shouldRequestFocus) {
                          state.requestFocus();
                        }
                        state.didChange(value);
                      }
                    : null,
                checkColor: checkColor,
                activeColor: activeColor,
                secondary: secondary,
                controlAffinity: controlAffinity,
                autofocus: autofocus,
                tristate: tristate,
                contentPadding: contentPadding,
                selected: selected,
                
                
              ),
            );
          },
        );

  @override
  FormBuilderFieldState<CustomCheckBox, bool> createState() =>
      _CustomCheckBoxState();
}

class _CustomCheckBoxState extends FormBuilderFieldState<CustomCheckBox, bool> {
}
