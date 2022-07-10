import 'package:flutter/material.dart';

import '../../../../core/widgets/app_template.dart';
import '../../../../core/widgets/custom_search_textfield.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      titleKey: 'kHistoryLabel',
      body: Column(
        children: [
          CustomSearchTextField(),
          // Expanded(
          //   flex: 2,
          //   child: Container(),
          // ),
        ],
      ),
    );
  }
}
