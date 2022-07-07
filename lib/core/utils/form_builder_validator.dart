import 'package:flutter/material.dart';

/// For creation of [FormFieldValidator]s.
class FormBuilderValidators {
  /// [FormFieldValidator] that is composed of other [FormFieldValidator]s.
  /// Each validator is run against the [FormField] value and if any returns a
  /// non-null result validation fails, otherwise, validation passes
  static FormFieldValidator<T> compose<T>(
      List<FormFieldValidator<T>> validators) {
    return (valueCandidate) {
      for (var validator in validators) {
        final validatorResult = validator.call(valueCandidate);
        if (validatorResult != null) {
          return validatorResult;
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field have a non-empty value.
  static FormFieldValidator<T> required<T>({
    required String errorText,
  }) {
    return (T? valueCandidate) {
      if (valueCandidate == null ||
          (valueCandidate is String && valueCandidate.trim().isEmpty) ||
          (valueCandidate is Iterable && valueCandidate.isEmpty) ||
          (valueCandidate is Map && valueCandidate.isEmpty)) {
        return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field have a non-empty value.
  static FormFieldValidator<T> requiredMinText<T>({
    required String errorText,
  }) {
    return (T? valueCandidate) {
      if ((valueCandidate is String && valueCandidate.length <= 30)) {
        return errorText;
      }
      return null;
    };
  }

  static FormFieldValidator<T> requiredSync<T>(
      {required String errorText, String? secondValue}) {
    return (firstValue) {
      if ((firstValue == null ||
              (firstValue is String && firstValue.trim().isEmpty)) &&
          (secondValue == null ||
              (secondValue is String && secondValue.trim().isEmpty))) {
        return errorText;
      }
      return null;
    };
  }

  // /// [FormFieldValidator] that requires the field's value be equal to the
  // /// provided value.
  // static FormFieldValidator<T> equal<T>(
  //   BuildContext context,
  //   T value, {
  //   String? errorText,
  // }) =>
  //     (valueCandidate) => valueCandidate != value
  //         ? errorText ??
  //             FormBuilderLocalizations.of(context).equalErrorText(value)
  //         : null;

  // /// [FormFieldValidator] that requires the field's value be not equal to
  // /// the provided value.
  // static FormFieldValidator<T> notEqual<T>(
  //   BuildContext context,
  //   T value, {
  //   String? errorText,
  // }) =>
  //     (valueCandidate) => valueCandidate == value
  //         ? errorText ??
  //             FormBuilderLocalizations.of(context).notEqualErrorText(value)
  //         : null;

  // /// [FormFieldValidator] that requires the field's value to be greater than
  // /// (or equal) to the provided number.
  // static FormFieldValidator<T> min<T>(
  //   BuildContext context,
  //   num min, {
  //   bool inclusive = true,
  //   String? errorText,
  // }) {
  //   return (T? valueCandidate) {
  //     if (valueCandidate != null) {
  //       assert(valueCandidate is num || valueCandidate is String);
  //       final number = valueCandidate is num
  //           ? valueCandidate
  //           : num.tryParse(valueCandidate.toString());

  //       if (number != null && (inclusive ? number < min : number <= min)) {
  //         return errorText ??
  //             FormBuilderLocalizations.of(context).minErrorText(min);
  //       }
  //     }
  //     return null;
  //   };
  // }

  static FormFieldValidator<T> cannotBeLessThan<T>({
    required num min,
    bool inclusive = true,
    String? errorText,
  }) {
    return (T? valueCandidate) {
      if (valueCandidate != null) {
        assert(valueCandidate is num || valueCandidate is String);
        final number = valueCandidate is num
            ? valueCandidate
            : num.tryParse(valueCandidate.toString());

        if (number != null && (inclusive ? number < min : number <= min)) {
          return "$errorText";
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be less than
  /// (or equal) to the provided number.
  // static FormFieldValidator<T> max<T>(
  //   BuildContext context,
  //   num max, {
  //   bool inclusive = true,
  //   String? errorText,
  // }) {
  //   return (T? valueCandidate) {
  //     if (valueCandidate != null) {
  //       assert(valueCandidate is num || valueCandidate is String);
  //       final number = valueCandidate is num
  //           ? valueCandidate
  //           : num.tryParse(valueCandidate.toString());

  //       if (number != null && (inclusive ? number > max : number >= max)) {
  //         return errorText ??
  //             FormBuilderLocalizations.of(context).maxErrorText(max);
  //       }
  //     }
  //     return null;
  //   };
  // }

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// greater than or equal to the provided minimum length.
  // static FormFieldValidator<String> minLength(
  //   BuildContext context,
  //   int minLength, {
  //   bool allowEmpty = false,
  //   String? errorText,
  // }) {
  //   assert(minLength > 0);
  //   return (valueCandidate) {
  //     final valueLength = valueCandidate?.length ?? 0;
  //     return valueLength < minLength && (!allowEmpty || valueLength > 0)
  //         ? errorText ??
  //             FormBuilderLocalizations.of(context).minLengthErrorText(minLength)
  //         : null;
  //   };
  // }

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// less than or equal to the provided maximum length.
  // static FormFieldValidator<String> maxLength(
  //   BuildContext context,
  //   int maxLength, {
  //   String? errorText,
  // }) {
  //   assert(maxLength > 0);
  //   return (valueCandidate) => null != valueCandidate &&
  //           valueCandidate.length > maxLength
  //       ? errorText ??
  //           FormBuilderLocalizations.of(context).maxLengthErrorText(maxLength)
  //       : null;
  // }

  /// [FormFieldValidator] that requires the field's value to be a valid email address.
  // static FormFieldValidator<String> email({
  //   required String errorText,
  // }) =>
  //     (valueCandidate) =>
  //         true == valueCandidate?.isNotEmpty && !isEmail(valueCandidate!.trim())
  //             ? errorText
  //             : null;

  // /// [FormFieldValidator] that requires the field's value to be a valid url.
  // static FormFieldValidator<String> url(
  //   BuildContext context, {
  //   String? errorText,
  //   List<String> protocols = const ['http', 'https', 'ftp'],
  //   bool requireTld = true,
  //   bool requireProtocol = false,
  //   bool allowUnderscore = false,
  //   List<String> hostWhitelist = const [],
  //   List<String> hostBlacklist = const [],
  // }) =>
  //     (valueCandidate) => true == valueCandidate?.isNotEmpty &&
  //             !isURL(valueCandidate!,
  //                 protocols: protocols,
  //                 requireTld: requireTld,
  //                 requireProtocol: requireProtocol,
  //                 allowUnderscore: allowUnderscore,
  //                 hostWhitelist: hostWhitelist,
  //                 hostBlacklist: hostBlacklist)
  //         ? errorText ?? FormBuilderLocalizations.of(context).urlErrorText
  //         : null;

  // /// [FormFieldValidator] that requires the field's value to match the provided regex pattern.
  // static FormFieldValidator<String> phone(
  //   String pattern, {
  //   String? errorText,
  // }) =>
  //     (valueCandidate) => true == valueCandidate?.isNotEmpty &&
  //             !RegExp(pattern).hasMatch(valueCandidate!)
  //         ? errorText
  //         : null;

  // /// [FormFieldValidator] that requires the field's value to match the provided regex pattern.
  // static FormFieldValidator<String> match(
  //   BuildContext context,
  //   String pattern, {
  //   String? errorText,
  // }) =>
  //     (valueCandidate) => true == valueCandidate?.isNotEmpty &&
  //             !RegExp(pattern).hasMatch(valueCandidate!)
  //         ? errorText ?? FormBuilderLocalizations.of(context).matchErrorText
  //         : null;

  // /// [FormFieldValidator] that requires the field's value to be a valid number.
  // static FormFieldValidator<String> numeric(
  //   BuildContext context, {
  //   String? errorText,
  // }) =>
  //     (valueCandidate) => true == valueCandidate?.isNotEmpty &&
  //             null == num.tryParse(valueCandidate!)
  //         ? errorText ?? FormBuilderLocalizations.of(context).numericErrorText
  //         : null;

  // /// [FormFieldValidator] that requires the field's value to be a valid integer.
  // static FormFieldValidator<String> integer(
  //   BuildContext context, {
  //   String? errorText,
  //   int? radix,
  // }) =>
  //     (valueCandidate) => true == valueCandidate?.isNotEmpty &&
  //             null == int.tryParse(valueCandidate!, radix: radix)
  //         ? errorText ?? FormBuilderLocalizations.of(context).integerErrorText
  //         : null;

  // /// [FormFieldValidator] that requires the field's value to be a valid credit card number.
  // static FormFieldValidator<String> creditCard(
  //   BuildContext context, {
  //   String? errorText,
  // }) =>
  //     (valueCandidate) =>
  //         true == valueCandidate?.isNotEmpty && !isCreditCard(valueCandidate!)
  //             ? errorText ??
  //                 FormBuilderLocalizations.of(context).creditCardErrorText
  //             : null;

  // /// [FormFieldValidator] that requires the field's value to be a valid IP address.
  // /// * [version] is a `String` or an `int`.
  // static FormFieldValidator<String> ip(
  //   BuildContext context, {
  //   int? version,
  //   String? errorText,
  // }) =>
  //     (valueCandidate) =>
  //         true == valueCandidate?.isNotEmpty && !isIP(valueCandidate!, version)
  //             ? errorText ?? FormBuilderLocalizations.of(context).ipErrorText
  //             : null;

  // /// [FormFieldValidator] that requires the field's value to be a valid date string.
  // static FormFieldValidator<String> dateString(
  //   BuildContext context, {
  //   String? errorText,
  // }) =>
  //     (valueCandidate) =>
  //         true == valueCandidate?.isNotEmpty && !isDate(valueCandidate!)
  //             ? errorText ??
  //                 FormBuilderLocalizations.of(context).dateStringErrorText
  //             : null;

  /// [FormFieldValidator] that requires the time field have a date in future value.
  static FormFieldValidator<DateTime> futureDate({
    required String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate == null) {
        return errorText;
      }
      if (valueCandidate.isBefore(DateTime.now())) {
        return errorText;
      }
      return null;
    };
  }

  static FormFieldValidator<DateTime> pastDate({
    required String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate == null) {
        return errorText;
      }
      if (valueCandidate.isAfter(DateTime.now())) {
        return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the time field have a time in future value.
  static FormFieldValidator<DateTime> futureTime({
    required String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate == null) {
        return errorText;
      }
      var valueDoubleTime = toDouble(TimeOfDay.fromDateTime(valueCandidate));
      var nowDoubleTime = toDouble(TimeOfDay.now());
      if (valueDoubleTime < nowDoubleTime) {
        return errorText;
      }
      return null;
    };
  }

  static FormFieldValidator<String> mustBeA({
    required String errorText,
  }) {
    return (valueCandidate) {
      if (valueCandidate != 'a') {
        return errorText;
      }
      return null;
    };
  }

  static double toDouble(TimeOfDay myTime) =>
      myTime.hour + myTime.minute / 60.0;
}
