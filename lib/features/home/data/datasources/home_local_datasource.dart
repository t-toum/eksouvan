// import 'package:trakref/core/models/dropdown_model/dropdown_list_model.dart';
// import 'package:trakref/core/services/cached_api_service.dart';
// import 'package:trakref/core/services/database_service.dart';

import 'package:eksouvan/core/services/shared_preferences_service.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';

abstract class HomeLocalDatasource {
  Future<bool> logOut();
}

@LazySingleton(as: HomeLocalDatasource)
class HomeLocalDatasourceImpl extends HomeLocalDatasource {
  final SharedPreferencesService preferencesService;

  HomeLocalDatasourceImpl(this.preferencesService);
  @override
  Future<bool> logOut() async {
    try {
      return preferencesService.logOut(key: SharedPreferenceKey.uidKey);
    } catch (error) {
      throw CacheException(msg: error.toString());
    }
  }
}
