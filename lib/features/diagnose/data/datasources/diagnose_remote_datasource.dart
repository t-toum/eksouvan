import 'package:eksouvan/core/models/medicine_model.dart';
import 'package:eksouvan/core/services/cloud_firestore_service.dart';
import 'package:eksouvan/features/diagnose/data/model/deases_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';

abstract class DiagnoseRemoteDatasource {
  Future<String> addDiagnose(
      {required Map<String, dynamic> data, required String patientId});
  Future<List<DeasesModel>> getAllDeases();
  Future<String> addDeases({required DeasesModel deasesModel});
  Future<List<MedicineModel>> getAllMedicine();
  Future<String> addNewMedicine({required MedicineModel data});
}

@LazySingleton(as: DiagnoseRemoteDatasource)
class DiagnoseRemoteDatasourceImpl extends DiagnoseRemoteDatasource {
  final CloudFireStoreService cloudFireStoreService;

  DiagnoseRemoteDatasourceImpl(this.cloudFireStoreService);

  @override
  Future<String> addDiagnose(
      {required Map<String, dynamic> data, required String patientId}) async {
    try {
      final result = await cloudFireStoreService.addDiagnose(
          data: data, patientId: patientId);
      return result;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

  @override
  Future<List<DeasesModel>> getAllDeases() async {
    try {
      final result = await cloudFireStoreService.getAllDeases();
      return result;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

  @override
  Future<String> addDeases({required DeasesModel deasesModel}) async {
    try {
      return await cloudFireStoreService.addDeases(deasesModel: deasesModel);
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

  @override
  Future<List<MedicineModel>> getAllMedicine() async {
    try {
      final result = await cloudFireStoreService.getAllMedicine();
      return result;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }
  
  @override
  Future<String> addNewMedicine({required MedicineModel data}) async{
    try {
      return await cloudFireStoreService.addNewMedicine(model: data);
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }
}
