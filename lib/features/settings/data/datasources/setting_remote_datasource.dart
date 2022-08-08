import 'package:eksouvan/core/models/user_model.dart';
import 'package:injectable/injectable.dart';

abstract class SettingRemoteDatasource {
  Future<List<UserModel>> getAllUser();
}
@LazySingleton(as: SettingRemoteDatasource )
class SettingRemoteDatasourceUmpl extends SettingRemoteDatasource{
  @override
  Future<List<UserModel>> getAllUser() async{
    // TODO: implement getAllUser
    throw UnimplementedError();
  }

}