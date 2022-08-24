import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/core/models/medicine_model.dart';
import 'package:eksouvan/core/models/user_model.dart';
import 'package:eksouvan/core/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/medicine_type_mode.dart';
import '../../../../core/services/cloud_firestore_service.dart';

abstract class SettingRemoteDatasource {
  Future<List<UserModel>> getAllUser();
  Future<UserCredential> createUser(
      {required String email, required String password});
  Future<dynamic> saveUser({required UserModel data});
  Future<List<MedicineTypeMedel>> getMedicineType();
  Future<dynamic> addMedicineType({required MedicineTypeMedel data});
  Future<bool> deleteMedicineType({required String id});
  Future<bool> updateMedicine({required MedicineModel data});
  Future<bool> deleteMedicine({required String id});
}

@LazySingleton(as: SettingRemoteDatasource)
class SettingRemoteDatasourceUmpl extends SettingRemoteDatasource {
  final CloudFireStoreService fireStoreService;
  final AuthService authService;

  SettingRemoteDatasourceUmpl(this.fireStoreService, this.authService);
  @override
  Future<List<UserModel>> getAllUser() async {
    try {
      return await fireStoreService.getAllUser();
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

  @override
  Future<UserCredential> createUser(
      {required String email, required String password}) async {
    try {
      return await authService.createUser(email: email, password: password);
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

  @override
  Future saveUser({required UserModel data}) async {
    try {
      return await fireStoreService.saveUser(data: data);
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

  @override
  Future<List<MedicineTypeMedel>> getMedicineType() async {
    try {
      return await fireStoreService.getMedicineType();
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

  @override
  Future addMedicineType({required MedicineTypeMedel data}) async {
    try {
      return await fireStoreService.addMedicineType(data: data);
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

  @override
  Future<bool> deleteMedicineType({required String id}) async {
    try {
      return await fireStoreService.deleteMidicineType(uid: id);
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

  @override
  Future<bool> deleteMedicine({required String id}) async {
    try {
      return await fireStoreService.deleteMedicine(id: id);
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

  @override
  Future<bool> updateMedicine({required MedicineModel data}) async {
    try {
      return await fireStoreService.updateMedicine(data: data);
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }
}
