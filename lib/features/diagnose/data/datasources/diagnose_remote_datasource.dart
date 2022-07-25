import 'package:eksouvan/core/services/cloud_firestore_service.dart';
import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';

abstract class DiagnoseRemoteDatasource {
  Future<String> addDiagnose({required DiagnoseModel diagnoseModel});
}

@LazySingleton(as: DiagnoseRemoteDatasource)
class DiagnoseRemoteDatasourceImpl extends DiagnoseRemoteDatasource {
  final CloudFireStoreService cloudFireStoreService;

  DiagnoseRemoteDatasourceImpl(this.cloudFireStoreService);
  
  @override
  Future<String> addDiagnose({required DiagnoseModel diagnoseModel})async {
   try {
      final result = await cloudFireStoreService.addDiagnose(model: diagnoseModel);
      return result;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

}
