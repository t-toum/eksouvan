import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/entities/medicine.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/field_keys.dart';
import 'package:eksouvan/core/widgets/app_template.dart';
import 'package:eksouvan/core/widgets/custom_textfield_area.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/diagnose/domain/entity/deases.dart';
import 'package:eksouvan/features/diagnose/presentation/cubit/diagnose_cubit.dart';
import 'package:eksouvan/features/diagnose/presentation/cubit/diagnose_state.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DiagnoseCubit>();
    final List<Deases?> listDesase = cubit.formValue[FieldKeys.kDeases] ?? [];
    final List<Medicine?> listMedicine =
        cubit.formValue[FieldKeys.kMedicine] ?? [];
    return BlocBuilder<DiagnoseCubit, DiagnoseState>(
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
              child: TextButton(
                onPressed: () {
                  cubit.addPatientDiagnose();
                },
                child: Text(
                  LocaleKeys.kSave.tr(),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          ],
          title: LocaleKeys.kSummary.tr(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Image(
                      image: AssetImage(AppImages.default_avatar),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${cubit.formValue[FieldKeys.kFirstname]} ${cubit.formValue[FieldKeys.kLastname]}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(cubit.formValue[FieldKeys.kAddress] ?? ''),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  LocaleKeys.kDiagnosePatient.tr(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: List.generate(listDesase.length, (index) {
                      return ListTile(
                        leading: Text('${index + 1}'),
                        dense: true,
                        title: Text(listDesase[index]?.deases ?? ''),
                      );
                    }),
                  ),
                ),
                Text(
                  LocaleKeys.kMedicine.tr(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: List.generate(listMedicine.length, (index) {
                      return ListTile(
                        leading: Text('${index + 1}'),
                        dense: true,
                        title: Text(listMedicine[index]?.medicine ?? ''),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomTextFieldArea(
                    labelText: LocaleKeys.kDescription.tr(),
                    name: 'description',
                    initialValue: cubit.formValue[FieldKeys.kDescription],
                    enabled: false,
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
