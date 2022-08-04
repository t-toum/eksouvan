import 'package:flutter/material.dart';

class PatientItem extends StatelessWidget {
  final String? firstname;
  final String? lastname;
  final String? tel;
  final GestureTapCallback? onTap;
  const PatientItem(
      {Key? key, this.firstname, this.lastname, this.onTap, this.tel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "$firstname $lastname",
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text(tel ?? ''),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
