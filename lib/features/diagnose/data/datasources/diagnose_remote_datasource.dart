import 'package:eksouvan/core/services/cloud_firestore_service.dart';
import 'package:eksouvan/features/register_patient/data/model/patient_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';

abstract class DiagnoseRemoteDatasource {
  Future<bool> addDiagnose({required doc, required PatientModel patientModel});
}

@LazySingleton(as: DiagnoseRemoteDatasource)
class DiagnoseRemoteDatasourceImpl extends DiagnoseRemoteDatasource {
  final CloudFireStoreService cloudFireStoreService;

  DiagnoseRemoteDatasourceImpl(this.cloudFireStoreService);

  @override
  Future<bool> addDiagnose(
      {required doc, required PatientModel patientModel}) async {
    try {
      final result = await cloudFireStoreService.addDiagnose(
          doc: doc, patientModel: patientModel);
      return result;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }
}
