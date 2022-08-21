import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/widgets/custom_date_picker.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/reports/presentations/cubit/report_cubit.dart';
import 'package:eksouvan/features/reports/presentations/cubit/report_state.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/convert_datas.dart';
import '../widgets/report_patient_pdf.dart';

class ReportPatientPage extends StatelessWidget {
  const ReportPatientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> columns = [
      LocaleKeys.kNo.tr(),
      LocaleKeys.kGender.tr(),
      LocaleKeys.kFirstname.tr(),
      LocaleKeys.kLastName.tr(),
      LocaleKeys.kDateOfBirth.tr(),
      LocaleKeys.kRegisterDate.tr(),
    ];
    final cubit = context.read<ReportCubit>();
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        if (state.dataStatus == DataStatus.loading) {
          return const LoadingWidget(
            showImage: false,
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.kReportPatient.tr()),
            actions: [
              IconButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => ReportPatientPdf(
                            listPateint: state.listPatient,
                            startDate: cubit.startDate,
                            endDate: cubit.enddate,
                          )),
                    ),
                  );
                },
                icon: const Icon(Icons.print),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                //Filter section
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
                          cubit.onChangeDate();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: CustomDatePicker(
                        initialDate: DateTime.now(),
                        onChanged: (value) {
                          cubit.enddate = value;
                          cubit.onChangeDate();
                        },
                        title: LocaleKeys.kEndDate.tr(),
                        name: "end",
                      ),
                    ),
                  ],
                ),
                const Divider(),
                //Body
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        DataTable(
                          headingTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontSize: 18),
                          columns: List.generate(
                              columns.length,
                              (index) =>
                                  DataColumn(label: Text(columns[index]))),
                          rows: List.generate(
                            state.listPatient.length,
                            (index) {
                              final data = state.listPatient[index];
                              return DataRow(
                                cells: [
                                  DataCell(Text('${index + 1}')),
                                  DataCell(Text(ConvertDatas.convertGender(
                                      id: data.gender, isShort: true))),
                                  DataCell(Text(data.firstname ?? '')),
                                  DataCell(Text(data.lastname ?? '')),
                                  DataCell(Text(ConvertDatas.converDateFormat(
                                      data.birthday))),
                                  DataCell(Text(ConvertDatas.converDateFormat(
                                      data.createDate))),
                                ],
                              );
                            },
                          ),
                          showBottomBorder: true,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
