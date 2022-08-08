import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eksouvan/core/models/medicine_model.dart';
import 'package:eksouvan/core/models/user_model.dart';
import 'package:eksouvan/core/utils/convert_datas.dart';
import 'package:eksouvan/core/utils/field_keys.dart';
import 'package:eksouvan/features/appointments/data/models/appointment_model.dart';
import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../features/diagnose/data/model/deases_model.dart';
import '../../features/register/data/model/patient_model.dart';
import '../utils/constants.dart';

@injectable
class CloudFireStoreService {
  final FirebaseFirestore firebaseFirestore;
  final Uuid uuid;
  CloudFireStoreService(this.firebaseFirestore, this.uuid);

  Future<dynamic> getAllUser() async {
    try {
      final response = await firebaseFirestore.collection('users').get();
      return response.metadata;
    } on FirebaseException catch (error) {
      throw error.message ?? "";
    }
  }

  Future<String> addNewPatient({required PatientModel patientModel}) async {
    try {
      final response = await firebaseFirestore
          .collection(ColectionName.patient)
          .add(patientModel.toJson());
      return response.id;
    } on FirebaseException catch (error) {
      throw error.message ?? "add new patient";
    }
  }

  Future<List<PatientModel>> getAllPatient() async {
    List<PatientModel> listData = [];
    try {
      final result =
          await firebaseFirestore.collection(ColectionName.patient).get();
      for (var doc in result.docs) {
        var res = ConvertDatas.convertMapData(mapData: doc.data());
        res['patientId'] = doc.id;
        var data = PatientModel.fromJson(res);
        listData.add(data);
      }
      return listData;
    } on FirebaseException catch (error) {
      throw error.message ?? "Get all patient";
    }
  }

  Future<PatientModel> getPatient({required String patientId}) async {
    try {
      final result = await firebaseFirestore
          .collection(ColectionName.patient)
          .doc(patientId)
          .get();
      Map<String, dynamic> mapData = result.data() ?? {};
      mapData[FieldKeys.kPatientId] = result.id;
      var res = ConvertDatas.convertMapData(mapData: mapData);
      PatientModel data = PatientModel.fromJson(res);
      return data;
    } on FirebaseException catch (error) {
      throw error.message ?? "Get all patient";
    }
  }

  Future<String> addDiagnose({required DiagnoseModel data}) async {
    try {
      Map<String, dynamic> formValue = data.toJson();
      List<dynamic> listDeases =
          data.deases?.map((e) => e.toJson()).toList() ?? [];
      List<dynamic> listMedicine =
          data.medicines?.map((e) => e.toJson()).toList() ?? [];
      formValue[FieldKeys.kDeases] = FieldValue.arrayUnion(listDeases);
      formValue[FieldKeys.kMedicine] = FieldValue.arrayUnion(listMedicine);
      final response = await firebaseFirestore
          .collection(ColectionName.diagnose)
          .add(formValue);
      return response.id;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<DeasesModel>> getAllDeases() async {
    List<DeasesModel> listDeases = [];
    try {
      final res =
          await firebaseFirestore.collection(ColectionName.deases).get();
      for (var doc in res.docs) {
        Map<String, dynamic> mapData = doc.data();
        mapData['docId'] = doc.id;
        final DeasesModel model = DeasesModel.fromJson(mapData);
        listDeases.add(model);
      }
      return listDeases;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<String> addDeases({required DeasesModel deasesModel}) async {
    try {
      final res = await firebaseFirestore
          .collection(ColectionName.deases)
          .add(deasesModel.toJson());
      return res.id;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<MedicineModel>> getAllMedicine() async {
    List<MedicineModel> listMedicine = [];
    try {
      final res =
          await firebaseFirestore.collection(ColectionName.medicines).get();
      for (var doc in res.docs) {
        Map<String, dynamic> mapData = doc.data();
        mapData['docId'] = doc.id;
        final MedicineModel model = MedicineModel.fromJson(mapData);
        listMedicine.add(model);
      }
      return listMedicine;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<String> addNewMedicine({required MedicineModel model}) async {
    try {
      final res = await firebaseFirestore
          .collection(ColectionName.medicines)
          .add(model.toJson());
      return res.id;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<String> addAppointment({required AppointmentModel data}) async {
    try {
      final res = await firebaseFirestore
          .collection(ColectionName.appointments)
          .add(data.toJson());
      return res.id;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<AppointmentModel>> getAllAppointment() async {
    List<AppointmentModel> listAppointment = [];
    try {
      final res =
          await firebaseFirestore.collection(ColectionName.appointments).get();
      for (var docs in res.docs) {
        Map<String, dynamic> docsData = docs.data();
        docsData[FieldKeys.kDocId] = docs.id;
        AppointmentModel appointmentModel = AppointmentModel.formJson(docsData);
        listAppointment.add(appointmentModel);
      }
      return listAppointment;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<DiagnoseModel>> getAllDiagnose() async {
    List<DiagnoseModel> listDiagnose = [];
    try {
      final res =
          await firebaseFirestore.collection(ColectionName.diagnose).get();
      for (var docs in res.docs) {
        Map<String, dynamic> docsData = docs.data();
        docsData[FieldKeys.kDiagnoseId] = docs.id;
        DiagnoseModel diagnoseModel = DiagnoseModel.fromJson(docsData);
        listDiagnose.add(diagnoseModel);
      }
      return listDiagnose;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<UserModel>> getAllUserData() async {
    List<UserModel> listUser = [];
    try {
      final res = await firebaseFirestore.collection(ColectionName.users).get();
      for (var docs in res.docs) {
        Map<String, dynamic> docsData = docs.data();
        docsData[FieldKeys.kDocId] = docs.id;
        UserModel userModel = UserModel.fromJson(docsData);
        listUser.add(userModel);
      }
      return listUser;
    } catch (error) {
      throw error.toString();
    }
  }
}
