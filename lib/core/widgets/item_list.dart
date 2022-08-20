import 'package:eksouvan/core/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? description;
  final String? title;
  final Widget? trailing;
  final String? type;
  const ItemList({
    Key? key,
    this.onTap,
    this.title,
    this.description,
    this.trailing,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          minVerticalPadding: 10,
          leading: const Image(
            image: AssetImage(AppImages.medicine),
            width: 40,
            height: 40,
          ),
          trailing: trailing,
          title: Row(
            children: [
              Expanded(
                child: Text(
                  title ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  type ?? 'No type',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
          subtitle: Text(description ?? ''),
          onTap: onTap,
        ),
      ),
    );
  }
}
