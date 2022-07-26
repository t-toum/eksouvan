import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class ListPatientItem extends StatelessWidget {
  final String? firstname;
  final String? lastname;
  final String? address;
  final DateTime? lastUpdate;
  final GestureTapCallback? onTap;

  const ListPatientItem(
      {Key? key,
      this.firstname,
      this.lastname,
      this.lastUpdate,
      this.address,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.person,
            size: 35,
          ),
          title: Row(
            children: [
              Expanded(
                child: Text('$firstname $lastname'),
              ),
              Expanded(
                child: Text('$address'),
              ),
              Expanded(
                child: Text(DateFormatPattern.kShortDateFormat
                    .format(lastUpdate ?? DateTime.now())),
              ),
            ],
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
