import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/field_keys.dart';

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
        newValue[key] = double.parse(value);
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
