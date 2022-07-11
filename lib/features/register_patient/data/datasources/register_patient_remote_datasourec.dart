import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/core/services/cloud_firestore_service.dart';
import 'package:eksouvan/features/register_patient/data/model/patient_model.dart';
import 'package:injectable/injectable.dart';

abstract class RegisterPatientRemoteDatasource {
  Future<String> addNewPatient({required PatientModel patientModel});
}

@LazySingleton(as: RegisterPatientRemoteDatasource)
class RegisterPatientRemoteDatasourceImpl
    extends RegisterPatientRemoteDatasource {
  final CloudFireStoreService cloudFireStoreService;

  RegisterPatientRemoteDatasourceImpl(this.cloudFireStoreService);
  @override
  Future<String> addNewPatient({required PatientModel patientModel}) async {
    try {
      final result =
          await cloudFireStoreService.addNewPatient(patientModel: patientModel);
      return result;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }
}
