import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/core/services/cloud_firestore_service.dart';
import 'package:eksouvan/features/appointments/data/models/appointment_model.dart';
import 'package:injectable/injectable.dart';

abstract class AppointmentRemoteDatasource {
  Future<String> addAppointment({required AppointmentModel data});
  Future<List<AppointmentModel>> getAllAppointment();
}

@LazySingleton(as: AppointmentRemoteDatasource)
class AppointmentRemoteDatasourceImpl extends AppointmentRemoteDatasource {
  final CloudFireStoreService cloudFireStoreService;

  AppointmentRemoteDatasourceImpl(this.cloudFireStoreService);
  @override
  Future<String> addAppointment({required AppointmentModel data}) async {
    try {
      final res = await cloudFireStoreService.addAppointment(data: data);
      return res;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }

  @override
  Future<List<AppointmentModel>> getAllAppointment() async {
    try {
      final res = await cloudFireStoreService.getAllAppointment();
      return res;
    } catch (error) {
      throw ServerException(msg: error.toString());
    }
  }
}
