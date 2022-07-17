import 'package:easy_localization/easy_localization.dart';

class ConvertDatas {
  static Map<String, dynamic> convertMapData(
      {required Map<String, dynamic> mapData}) {
    Map<String, dynamic> newValue = mapData;
    mapData.forEach((key, value) {
      if (value is DateTime) {
        newValue[key] = value.toString();
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
