import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class CloudFireStoreService {
  final FirebaseFirestore firebaseFirestore;
  CloudFireStoreService(this.firebaseFirestore);

  Future<dynamic> getAllUser() async {
    try {
      final response = await firebaseFirestore.collection('users').get();
      return response.metadata;
    } on FirebaseException catch (error) {
      throw error.message ?? "";
    }
  }
}
