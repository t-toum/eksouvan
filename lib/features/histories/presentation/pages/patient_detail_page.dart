import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/usecases/pdf_history_params.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/convert_datas.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/histories/presentation/cubit/history_cubit.dart';
import 'package:eksouvan/features/histories/presentation/cubit/history_state..dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_template.dart';
import '../../../../generated/locale_keys.g.dart';

class PatientDetailPage extends StatelessWidget {
  const PatientDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HistoryCubit>();
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (state.dataStatus == DataStatus.loading) {
          return const LoadingWidget();
        }
        return AppTemplate(
          title: LocaleKeys.kPatientHistory.tr(),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  AppNavigator.navigateTo(AppRoute.pdfPreviewRoute,
                      params: PdfHistoryParams(
                          patient: state.patient,
                          listAppointment: cubit.listAppointment ?? [],
                          listDiagnose: cubit.listDiagnose ?? []));
                },
                icon: const Icon(
                  Icons.print,
                ),
              ),
            )
          ],
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Image(
                      image: AssetImage(
                        AppImages.default_avatar,
                      ),
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${state.patient?.firstname} ${state.patient?.lastname} ',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(state.patient?.address ?? ''),
                      ],
                    ))
                  ],
                ),
                const Divider(),
                Text(
                  LocaleKeys.kDiagnoseHistory.tr(),
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                DataTable(
                  columns: List.generate(historyColumn.length, (index) {
                    return DataColumn(
                      label: Text(
                        historyColumn[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }),
                  rows: List.generate(
                    cubit.listDiagnose?.length ?? 0,
                    (index) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              ConvertDatas.converDateFormat(
                                  cubit.listDiagnose?[index].diagnoseDate),
                            ),
                          ),
                          DataCell(
                            Text(cubit.listDiagnose?[index].deases
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', '') ??
                                ''),
                          ),
                          DataCell(
                            Text(cubit.listDiagnose?[index].medicines
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', '') ??
                                ''),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                //Appointment
                const Divider(),
                Text(
                  LocaleKeys.kAppointmentHistory.tr(),
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                DataTable(
                  columns: List.generate(historyAppointment.length, (index) {
                    return DataColumn(
                      label: Text(
                        historyAppointment[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }),
                  rows: List.generate(
                    cubit.listAppointment?.length ?? 0,
                    (index) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              ConvertDatas.converDateFormat(
                                  cubit.listAppointment?[index].dueDate),
                            ),
                          ),
                          DataCell(
                            Text(cubit.listAppointment?[index].description ??
                                ''),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
