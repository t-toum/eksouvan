import 'package:eksouvan/core/utils/constants.dart';
import 'package:equatable/equatable.dart';

class SettingState extends Equatable {
  const SettingState({
    this.dataStatus = DataStatus.initial,
    this.error,
  });

  final DataStatus dataStatus;
  final String? error;

  SettingState copyWith({
    DataStatus? dataStatus,
    String? error,
  }) {
    return SettingState(
      dataStatus: dataStatus ?? this.dataStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [dataStatus, error];
}
