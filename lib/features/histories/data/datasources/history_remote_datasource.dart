import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/core/services/cloud_firestore_service.dart';
import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';
import 'package:eksouvan/features/register/data/model/patient_model.dart';
import 'package:injectable/injectable.dart';

abstract class HistoryRemoteDataSource {
  Future<List<PatientModel>> getAllPatient();
  Future<PatientModel> getPatient({required String patientId});
  Future<List<DiagnoseModel>> getAllDiagnose();
  Future<DiagnoseModel> getDiagnoseByPatient({required String patientId});
}

@LazySingleton(as: HistoryRemoteDataSource)
class HistoryRemoteDataSourceImpl extends HistoryRemoteDataSource {
  final CloudFireStoreService cloudFireStoreService;

  HistoryRemoteDataSourceImpl(this.cloudFireStoreService);
  @override
  Future<List<PatientModel>> getAllPatient() async {
    try {
      final result = await cloudFireStoreService.getAllPatient();
      return result;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

  @override
  Future<PatientModel> getPatient({required String patientId}) async {
    try {
      final result =
          await cloudFireStoreService.getPatient(patientId: patientId);
      return result;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

  @override
  Future<List<DiagnoseModel>> getAllDiagnose() async {
    try {
      final result = await cloudFireStoreService.getAllDiagnose();
      return result;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }
  
  @override
  Future<DiagnoseModel> getDiagnoseByPatient({required String patientId}) async{
    try {
      final result = await cloudFireStoreService.getDiagnoseByPatient(patientId: patientId);
      return result;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }
}
