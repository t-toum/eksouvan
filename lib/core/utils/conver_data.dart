class ConverData {
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
}
