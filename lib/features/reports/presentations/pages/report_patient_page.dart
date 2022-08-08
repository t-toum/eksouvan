import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/widgets/custom_date_picker.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/reports/presentations/cubit/report_cubit.dart';
import 'package:eksouvan/features/reports/presentations/cubit/report_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportPatientPage extends StatelessWidget {
  const ReportPatientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        if (state.dataStatus == DataStatus.loading) {
          return const LoadingWidget(
            showImage: false,
          );
        }
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.print),
              ),
            ],
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   width: 300,
                //   child: CustomDatePicker(
                //     name: 'date',
                //     title: 'Date',
                //   ),
                // ),
                Column(
                  children: List.generate(state.listPatient.length, (index) {
                    return ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(
                        '${state.listPatient[index].firstname} ${state.listPatient[index].lastname}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
