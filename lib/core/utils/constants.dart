import 'package:easy_localization/easy_localization.dart';
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
}

class AppColors {
  static const Color primaryColor = Color(0xFF11464A);
  static const Color secondaryColor = Color(0xFF168C8C);
}

class DatabaseInfo {
  static const String DATABASE_URL =
      "mongodb+srv://toum:Toum123@cluster0.uy45j.mongodb.net/eksouvan_db?retryWrites=true&w=majority";
}

class AppImages {
  static const String brannerImg = "assets/images/branner.png";
  static const String branner_outline = "assets/images/branner_outline21.png";
  static const String default_avatar = "assets/images/default_avatar.png";
  static const String animat_crying = "assets/images/crying.gif";
  static const String success = "assets/images/success.png";
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
}

class DateFormatPattern {
  static DateFormat kShortDateFormat = DateFormat('yyyy-MM-dd');
}
