import 'package:eksouvan/core/entities/medicine.dart';
import 'package:eksouvan/core/entities/medicine_type.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/entities/user.dart';

class SettingState extends Equatable {
  const SettingState({
    this.dataStatus = DataStatus.initial,
    this.error,
    this.listUser,
    this.listMedicine,
    this.listMedicineType,
  });

  final DataStatus dataStatus;
  final String? error;
  final List<User>? listUser;
  final List<Medicine>? listMedicine;
  final List<MedicineType>? listMedicineType;

  SettingState copyWith({
    DataStatus? dataStatus,
    String? error,
    List<User>? listUser,
    List<Medicine>? listMedicine,
    List<MedicineType>? listMedicineType,
  }) {
    return SettingState(
      dataStatus: dataStatus ?? this.dataStatus,
      error: error ?? this.error,
      listUser: listUser ?? this.listUser,
      listMedicine: listMedicine ?? this.listMedicine,
      listMedicineType: listMedicineType ?? this.listMedicineType,
    );
  }

  @override
  List<Object?> get props => [
        dataStatus,
        error,
        listUser,
        listMedicine,
        listMedicineType,
      ];
}
