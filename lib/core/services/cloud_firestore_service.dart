import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';
import 'package:eksouvan/features/register_patient/data/model/patient_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

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
    final String uid = uuid.v4();
    Map<String, dynamic> body = patientModel.toJson();
    body['patientId'] = uid;
    try {
      await firebaseFirestore.collection('patients').doc(uid).set(body);
      return uid;
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
        var data = PatientModel.fromJson(doc.data());
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
      PatientModel data = PatientModel.fromJson(result.data() ?? {});
      return data;
    } on FirebaseException catch (error) {
      throw error.message ?? "Get all patient";
    }
  }

  Future<bool> addDiagnose({required DiagnoseModel model}) async {
    try {
      await firebaseFirestore
          .collection(ColectionName.diagnose)
          .doc(model.diagnoseId)
          .set(model.toJson());
      return true;
    } catch (error) {
      throw error;
    }
  }
}
