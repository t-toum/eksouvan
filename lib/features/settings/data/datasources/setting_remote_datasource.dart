
import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/core/models/user_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/cloud_firestore_service.dart';

abstract class SettingRemoteDatasource {
  Future<List<UserModel>> getAllUser();
}

@LazySingleton(as: SettingRemoteDatasource)
class SettingRemoteDatasourceUmpl extends SettingRemoteDatasource {
  final CloudFireStoreService fireStoreService;

  SettingRemoteDatasourceUmpl(this.fireStoreService);
  @override
  Future<List<UserModel>> getAllUser() async {
    try {
      return await fireStoreService.getAllUser();
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }
}
