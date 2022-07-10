import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SharedPreferencesService {
  final SharedPreferences sharedPreferences;
  SharedPreferencesService(this.sharedPreferences);

  Future<bool> setValueString(
      {required String key, required String? value}) async {
    return await sharedPreferences.setString(key, value??'');
  }

  Future<String?> getString({required String key}) async {
    return sharedPreferences.getString(key);
  }
}
