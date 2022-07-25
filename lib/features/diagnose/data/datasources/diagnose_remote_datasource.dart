import 'package:eksouvan/core/services/cloud_firestore_service.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';

abstract class DiagnoseRemoteDatasource {
  Future<String> addDiagnose(
      {required Map<String, dynamic> data, required String patientId});
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
}
