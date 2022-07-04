import 'package:flutter/material.dart';

enum DataStatus { initial, loading, success, failure }

const baseUrl = "";

//Language
class Languages {
  static const String langPath = 'assets/translations/';
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
