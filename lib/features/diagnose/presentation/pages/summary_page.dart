import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/widgets/app_template.dart';
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
    return BlocBuilder<DiagnoseCubit, DiagnoseState>(
      builder: (context, state) {
        return AppTemplate(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {},
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
                            'Name Surname',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Address'),
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
                    children: List.generate(10, (index) {
                      return ListTile(
                        leading: Text('${index + 1}'),
                        dense: true,
                        title: Text('FRESD'),
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
                    children: List.generate(5, (index) {
                      return ListTile(
                        leading: Text('${index + 1}'),
                        dense: true,
                        title: Text('FRESD'),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
