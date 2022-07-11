import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eksouvan/features/register_patient/data/model/patient_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

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
    body['uid'] = uid;
    try {
      await firebaseFirestore
          .collection('patients')
          .doc(uid)
          .set(patientModel.toJson());
      return uid;
    } on FirebaseException catch (error) {
      throw error.message ?? "add new patient";
    }
  }
}
