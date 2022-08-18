import 'package:easy_localization/easy_localization.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_cubit.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_state.dart';
import 'package:eksouvan/features/settings/presentation/widgets/add_user_modal_widget.dart';
import 'package:eksouvan/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SettingUserPage extends StatelessWidget {
  const SettingUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingCubit>();
    return BlocBuilder<SettingCubit, SettingState>(builder: ((context, state) {
      if (state.dataStatus == DataStatus.loading) {
        return const LoadingWidget(
          showImage: false,
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.kUser.tr()),
          actions: [
            IconButton(
              onPressed: () async {
                await showCupertinoModalBottomSheet(
                  context: context,
                  expand: true,
                  enableDrag: false,
                  builder: ((_) => BlocProvider<SettingCubit>.value(
                        value: context.read<SettingCubit>(),
                        child: const AddUserModalWidget(),
                      )),
                );
                await cubit.getAllUser();
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: List.generate(state.listUser?.length ?? 0, (index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.account_circle,
                      size: 40,
                    ),
                    title: Row(children: [
                      Expanded(
                        child: Text(state.listUser?[index].name ?? ''),
                      ),
                      Expanded(
                        child: Text(state.listUser?[index].email ?? ''),
                      ),
                    ]),
                    trailing: InkWell(
                      child: const Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.red,
                      ),
                      onTap: () {
                        print("delete");
                      },
                    ),
                    onTap: () {
                      print('Update Detail');
                    },
                  ),
                ),
              );
            }),
          ),
        )),
      );
    }));
  }
}
