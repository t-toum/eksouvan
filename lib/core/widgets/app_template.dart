
import 'package:eksouvan/core/widgets/widget_builder.dart';
import 'package:flutter/material.dart';

class AppTemplate extends StatelessWidget {
  final Widget body;
  final String? title;
  const AppTemplate({Key? key, required this.body, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetBuilders.customAppbar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              title?? "Title",
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: body,
              ),
            )
          ],
        ),
      ),
    );
  }
}
