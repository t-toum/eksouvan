import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/field_keys.dart';
import 'package:eksouvan/features/diagnose/domain/entity/deases.dart';

class ConvertDatas {
  static Map<String, dynamic> convertMapData(
      {required Map<String, dynamic> mapData}) {
    Map<String, dynamic> newValue = {};
    mapData.forEach((key, value) {
      if (value is DateTime) {
        newValue[key] = value.toString();
      } else if (key == FieldKeys.kWeight ||
          key == FieldKeys.kHeight ||
          key == FieldKeys.kBloodPressure ||
          key == FieldKeys.kTemperature) {
        if (value is double) {
          newValue[key] = double.parse(value.toString());
        } else {
          newValue[key] =
              (value == null || value == "") ? null : double.parse(value);
        }
      } else if (value is Timestamp) {
        var time =
            DateTime.fromMillisecondsSinceEpoch(value.microsecondsSinceEpoch);
        newValue[key] = time.toString();
      } else {
        newValue[key] = value;
      }
    });
    return newValue;
  }

  static String converDateFormat(DateTime? dateTime) {
    if (dateTime == null) {
      return 'No data';
    } else {
      final inputDateFormat = DateFormat('dd-MM-yyyy');
      return inputDateFormat.format(dateTime);
    }
  }
}
