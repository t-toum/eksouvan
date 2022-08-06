import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class AppointmentItem extends StatelessWidget {
  final String? no;
  final String? displayName;
  final String? appointmentDate;
  final String? dueDate;
  final GestureTapCallback? onTap;
  const AppointmentItem(
      {Key? key,
      this.displayName,
      this.appointmentDate,
      this.dueDate,
      this.no,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            leading: Text(no ?? ''),
            title: Row(
              children: [
                Expanded(
                  child: Text('$displayName'),
                ),
                Expanded(
                  child: Text(appointmentDate ?? ''),
                )
              ],
            ),
            trailing: Text("${LocaleKeys.kDueDate.tr()}: $dueDate"),
            onTap: onTap),
        const Divider()
      ],
    );
  }
}
