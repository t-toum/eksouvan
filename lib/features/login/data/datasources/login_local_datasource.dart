import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/core/services/shared_preferences_service.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/constants.dart';

abstract class LoginLocalDataSource {
  Future<String?> getUserLogin();
}

@LazySingleton(as: LoginLocalDataSource)
class LoginLocalDatasourecImpl extends LoginLocalDataSource {
  final SharedPreferencesService preferencesService;

  LoginLocalDatasourecImpl(this.preferencesService);
  @override
  Future<String?> getUserLogin() {
    try {
      return preferencesService.getString(key: SharedPreferenceKey.uidKey);
    } catch (error) {
      throw CacheException(msg: error.toString());
    }
  }
}
