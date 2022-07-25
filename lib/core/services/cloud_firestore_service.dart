import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eksouvan/core/utils/convert_datas.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

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
    final String uid = uuid.v4();
    Map<String, dynamic> body = patientModel.toJson();
    body['patientId'] = uid;
    try {
      await firebaseFirestore
          .collection(ColectionName.patient)
          .doc(uid)
          .set(body);
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
        var res = ConvertDatas.convertMapData(mapData: doc.data());
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
      var res = ConvertDatas.convertMapData(mapData: result.data() ?? {});
      PatientModel data = PatientModel.fromJson(res);
      return data;
    } on FirebaseException catch (error) {
      throw error.message ?? "Get all patient";
    }
  }

  Future<String> addDiagnose(
      {required Map<String, dynamic> data, required String patientId}) async {
    try {
      await firebaseFirestore
          .collection(ColectionName.patient)
          .doc(patientId)
          .update(data);
      return 'Updated';
    } catch (error) {
      throw error.toString();
    }
  }
}
