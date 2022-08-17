import 'package:eksouvan/core/utils/constants.dart';
import 'package:eksouvan/core/widgets/loading_widget.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_cubit.dart';
import 'package:eksouvan/features/settings/presentation/cubit/setting_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingUserPage extends StatelessWidget {
  const SettingUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(builder: ((context, state) {
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
                    title: Text(state.listUser?[index].name ?? ''),
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
