import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/widgets/custom_search_textfield.dart';
import 'package:flutter/material.dart';

class MedicineWidget extends StatelessWidget {
  const MedicineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchTextField(),
        Column(
          children: List.generate(
            50,
            (index) => ListTile(
              title: Text('Title'),
              onTap: () {
                AppNavigator.goBack();
              },
            ),
          ),
        ),
      ],
    );
  }
}
