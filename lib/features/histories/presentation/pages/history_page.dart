import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/app_navigator.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/utils/router.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/histories/presentation/cubit/history_cubit.dart';
import 'package:eksouvan/features/histories/presentation/cubit/history_state..dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_template.dart';
import '../../../../core/widgets/custom_search_textfield.dart';
import '../widgets/list_items.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      title:LocaleKeys.kHistoryLabel.tr(),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state.dataStatus == DataStatus.loading) {
            return const LoadingWidget(
              showImage: false,
              title: "Loading...",
            );
          }
          return Column(
            children: [
              CustomSearchTextField(
                controller: context.read<HistoryCubit>().searchController,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children:
                          List.generate(state.listPatient.length, (index) {
                        return ListItems(
                          leading: '${index + 1}',
                          firstname: state.listPatient[index].firstname,
                          lastname: state.listPatient[index].lastname,
                          address: state.listPatient[index].address,
                          // listDeases: [],
                          onTap: () {
                            AppNavigator.navigateTo(AppRoute.patientDetailRoute,
                                params: state.listPatient[index].patientId);
                          },
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
