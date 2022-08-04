import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/widgets/custom_search_textfield.dart';
import 'package:eksouvan/features/appointments/presentation/widgets/patient_item.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/appointment_cubit.dart';
import '../cubit/appointment_state.dart';

class PatientModal extends StatelessWidget {
  const PatientModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppointmentCubit>();
    return Scaffold(
      body: BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        AppNavigator.goBack();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      LocaleKeys.kPatinet.tr(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(),
                  ],
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomSearchTextField(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(state.listPatient?.length ?? 0,
                            (index) {
                          return PatientItem(
                            firstname: state.listPatient?[index].firstname,
                            lastname: state.listPatient?[index].lastname,
                            tel: state.listPatient?[index].tel,
                            onTap: () {
                              AppNavigator.goBackWithData(
                                  data: state.listPatient?[index].patientId);
                            },
                          );
                        }),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
