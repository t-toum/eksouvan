import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eksouvan/core/services/cloud_firestore_service.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // getData();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Container(
          height: 100,
          width: double.infinity,
          color: AppColors.primaryColor,
          child: const Image(
            image: AssetImage(AppImages.branner_outline),
          ),
        ),
      ),
      body: Container(
          child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child: const Text("He'd have you all unravel at the"),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[200],
            child: const Text('Heed not the rabble'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[300],
            child: const Text('Sound of screams but the'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[400],
            child: const Text('Who scream'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[500],
            child: const Text('Revolution is coming...'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[600],
            child: const Text('Revolution, they...'),
          ),
        ],
      )),
    );
  }

  void getData() async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      final response = await firebaseFirestore.collection('users').doc().get();
      print(response.metadata);
    } on FirebaseException catch (error) {
      throw error.message ?? "";
    }
  }
}
