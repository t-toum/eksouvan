import 'package:eksouvan/core/error/exceptions.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/shared_preferences_service.dart';
import '../../../../core/utils/constants.dart';

abstract class SettingLocalDatasource {
  Future<bool> setLanguage({required String langCode});
  Future<String> getLanguage();
}

@LazySingleton(as: SettingLocalDatasource)
class SettingLocalDatasourceImpl extends SettingLocalDatasource {
  final SharedPreferencesService pref;
  SettingLocalDatasourceImpl(this.pref);
  @override
  Future<bool> setLanguage({required String langCode}) async {
    try {
      final res = await pref.setValueString(
          key: Languages.languageCode, value: langCode);
      return res;
    } catch (error) {
      throw CacheException(msg: error.toString());
    }
  }

  @override
  Future<String> getLanguage() async {
    try {
      final res = await pref.getString(key: Languages.languageCode);
      return res ?? '';
    } catch (error) {
      throw CacheException(msg: error.toString());
    }
  }
}
