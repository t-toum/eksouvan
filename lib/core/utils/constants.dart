import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/dropdown_item.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

enum DataStatus {
  initial,
  loading,
  success,
  failure,
  changeValue,
  saveDeaseSuccess,
  saveMedicineSucess,
  saveAppointmentSuccess,
}

const baseUrl = "";

//Language
class Languages {
  static const String langPath = 'assets/translations';
  static const String loCode = 'lo';
  static const String enCode = 'en';
  static const String languageCode = 'languageCode';
}

class AppColors {
  static const Color primaryColor = Color(0xFF11464A);
  static const Color secondaryColor = Color(0xFF168C8C);
}

class AppImages {
  static const String brannerImg = "assets/images/branner.png";
  static const String branner_outline = "assets/images/branner_outline21.png";
  static const String default_avatar = "assets/images/default_avatar.png";
  static const String animat_crying = "assets/images/crying.gif";
  static const String success = "assets/images/success.png";
  static const String report = "assets/images/report.png";
  static const String translate_black = "assets/images/translate_black.png";
  static const String translate_blue = "assets/images/translate_blue.png";
  static const String user = "assets/images/user.png";
  static const String patient = "assets/images/patient.png";
  static const String pill = "assets/images/pill.png";
  static const String medicine = "assets/images/medicine.png";
  static const String deases = "assets/images/deases.png";
}

//SharedPreferences
class SharedPreferenceKey {
  static const String uidKey = "uid";
  static const String email = "email";
}

class ColectionName {
  static const String users = "users";
  static const String patient = "patients";
  static const String diagnose = "diagnoses";
  static const String deases = "deases";
  static const String medicines = "medicines";
  static const String appointments = "appointments";
  static const String medicine_type = "medicine_type";
}

class DateFormatPattern {
  static DateFormat kShortDateFormat = DateFormat('yyyy-MM-dd');
}

List<String> historyColumn = [
  LocaleKeys.kAppointmentDate.tr(),
  LocaleKeys.kDiseases.tr(),
  LocaleKeys.kMedicine.tr()
];

List<String> historyAppointment = [
  LocaleKeys.kAppointment.tr(),
  LocaleKeys.kDescription.tr(),
];

//Blood Type
List<DropdwonItems> listBloodType = [
  DropdwonItems(id: "A", name: "A"),
  DropdwonItems(id: "B", name: "B"),
  DropdwonItems(id: "AB", name: "AB"),
  DropdwonItems(id: "O", name: "O"),
];

final List<String> reportPatientcolumns = [
  LocaleKeys.kNo.tr(),
  LocaleKeys.kGender.tr(),
  LocaleKeys.kFirstname.tr(),
  LocaleKeys.kLastName.tr(),
  LocaleKeys.kDateOfBirth.tr(),
  LocaleKeys.kRegisterDate.tr(),
];

final List<String> reportDiagnoseColumns = [
  LocaleKeys.kNo.tr(),
 LocaleKeys.kDate.tr(),
  LocaleKeys.kDeases.tr(),
  LocaleKeys.kMedicine.tr(),
  LocaleKeys.kDescription.tr(),
];
