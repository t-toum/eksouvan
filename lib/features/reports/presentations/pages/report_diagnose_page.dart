import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/convert_datas.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/reports/presentations/cubit/report_cubit.dart';
import 'package:eksouvan/features/reports/presentations/cubit/report_state.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_date_picker.dart';

class ReportDiagnosePage extends StatelessWidget {
  const ReportDiagnosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReportCubit>();
    return BlocBuilder<ReportCubit, ReportState>(
      builder: ((context, state) {
        if (state.dataStatus == DataStatus.loading) {
          return const LoadingWidget(showImage: false);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.kReportDiagnose.tr()),
            actions: [
              IconButton(
                onPressed: () async {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: ((context) => ReportPatientPdf(
                  //           listPateint: state.listPatient,
                  //           startDate: cubit.startDate,
                  //           endDate: cubit.enddate,
                  //         )),
                  //   ),
                  // );
                },
                icon: const Icon(Icons.print),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 200,
                      child: CustomDatePicker(
                        title: LocaleKeys.kStartDate.tr(),
                        name: "start",
                        onChanged: (value) {
                          cubit.startDate = value;
                          cubit.onChangedDiagnose();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: CustomDatePicker(
                        initialDate: DateTime.now(),
                        onChanged: (value) {
                          cubit.enddate = value;
                          cubit.onChangedDiagnose();
                        },
                        title: LocaleKeys.kEndDate.tr(),
                        name: "end",
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: List.generate(
                          reportDiagnoseColumns.length,
                          (index) => DataColumn(
                              label: Text(reportDiagnoseColumns[index]))),
                      rows: List.generate(state.listDiagnose.length, (index) {
                        final data = state.listDiagnose[index];
                        return DataRow(cells: [
                          DataCell(Text("${index + 1}")),
                          DataCell(Text(ConvertDatas.converDateFormat(
                              data.diagnoseDate))),
                          DataCell(Text(data.deases
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', ''))),
                          DataCell(Text(data.medicines
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', ''))),
                          DataCell(Text(data.description ?? "")),
                        ]);
                      }),
                    ),
                  ),
                ))
              ],
            ),
          ),
        );
      }),
    );
  }
}
