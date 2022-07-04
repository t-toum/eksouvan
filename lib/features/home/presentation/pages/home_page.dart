import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../../../core/utils/constants.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 8,
            ),
            Text(tr('kAppTitle')),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getUses(),
        builder: (context, snapshort) {
          if (!snapshort.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List data = snapshort.data as List;
            return Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                  child: Column(
                children: List.generate(data.length, (index) {
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                      data[index]['name'],
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    subtitle: Text(
                      data[index]['age'].toString(),
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  );
                }),
              )),
            );
          }
        },
      ),
    );
  }

  Future<dynamic> getUses() async {
    final db = await Db.create(DatabaseInfo.DATABASE_URL);
    await db.open();
    var coll = db.collection('Users');
    return coll.find().toList();
  }
}
