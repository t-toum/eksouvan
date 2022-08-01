// ignore_for_file: unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';

class ListItems extends StatelessWidget {
  final String? leading;
  final String? firstname;
  final String? lastname;
  final String? address;
  final GestureTapCallback? onTap;
  // final List<Deases>? listDeases;
  const ListItems({
    Key? key,
    this.leading,
    this.firstname,
    this.lastname,
    this.address,
    this.onTap,
    // this.listDeases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Text(leading ?? ''),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text("${firstname ?? 'No data'} ${lastname ?? ''}"),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(address ?? 'No data'),
              ),
              const SizedBox(
                width: 10,
              ),
              // Expanded(
              //   child: Text(listDeases.toString()),
              // ),
            ],
          ),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
