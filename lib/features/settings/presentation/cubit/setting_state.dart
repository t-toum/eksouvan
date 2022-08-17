import 'package:eksouvan/core/utils/constants.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/entities/user.dart';

class SettingState extends Equatable {
  const SettingState({
    this.dataStatus = DataStatus.initial,
    this.error,
    this.listUser,
  });

  final DataStatus dataStatus;
  final String? error;
  final List<User>? listUser;

  SettingState copyWith({
    DataStatus? dataStatus,
    String? error,
    List<User>?listUser,
  }) {
    return SettingState(
      dataStatus: dataStatus ?? this.dataStatus,
      error: error ?? this.error,
      listUser: listUser??this.listUser,
    );
  }

  @override
  List<Object?> get props => [dataStatus, error,listUser];
}
