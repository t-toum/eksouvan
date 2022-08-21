import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/convert_datas.dart';
import 'package:eksouvan/core/widgets/app_template.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/appointments/presentation/widgets/add_appointment.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../cubit/appointment_cubit.dart';
import '../cubit/appointment_state.dart';
import '../widgets/appointment_item.dart';
import '../widgets/modal_appointment_widget.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppointmentCubit>();
    return BlocConsumer<AppointmentCubit, AppointmentState>(
      listener: (context, state) {
        if (state.dataStatus == DataStatus.saveAppointmentSuccess) {
          AppNavigator.goBack();
          cubit.getAppointment();
        }
      },
      builder: (context, state) {
        if (state.dataStatus == DataStatus.loading) {
          return const LoadingWidget(
            showImage: false,
          );
        }
        return AppTemplate(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  showCupertinoModalBottomSheet(
                    expand: true,
                    enableDrag: false,
                    context: context,
                    builder: (newContext) {
                      return BlocProvider<AppointmentCubit>.value(
                        value: context.read<AppointmentCubit>(),
                        child: const AddAppointmentWidget(),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add),
              ),
            )
          ],
          title: LocaleKeys.kAppointment.tr(),
          body: Column(
            children: List.generate(
              state.listAppointment?.length ?? 0,
              (index) {
                return AppointmentItem(
                  no: '${index + 1}',
                  displayName: cubit.getPatient(
                      patientId: state.listAppointment?[index].patientId),
                  appointmentDate: ConvertDatas.converDateFormat(
                      state.listAppointment?[index].appointmentDate),
                  dueDate: ConvertDatas.converDateFormat(
                      state.listAppointment?[index].dueDate),
                  onTap: () {
                    AppNavigator.openModel(
                      chiled: const ModalAppointmentWidget(),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
