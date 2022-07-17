import 'package:eksouvan/features/histories/presentation/cubit/history_cubit.dart';
import 'package:eksouvan/features/histories/presentation/cubit/history_state..dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_template.dart';

class PatientDetailPage extends StatelessWidget {
  const PatientDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      body: BlocBuilder<HistoryCubit,HistoryState>(
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}
