import 'package:flutter/material.dart';

class ListPatientItem extends StatelessWidget {
  final String? firstname;
  final String? lastname;
  final String? tel;
  final String? address;
  final String? lastUpdate;
  final GestureTapCallback? onTap;
  const ListPatientItem(
      {Key? key,
      this.firstname,
      this.lastname,
      this.tel,
      this.address,
      this.lastUpdate,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: Row(
            children: [
              Expanded(child: Text('${firstname ?? ''} ${lastname ?? ''}')),
              Expanded(child: Text(tel ?? '')),
              Expanded(child: Text(address ?? '')),
            ],
          ),
          trailing: Text(lastUpdate ?? ''),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
