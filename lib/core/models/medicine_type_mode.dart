import 'package:eksouvan/core/entities/medicine_type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'medicine_type_mode.g.dart';

@JsonSerializable()
class MedicineTypeMedel extends MedicineType {
  const MedicineTypeMedel({
    String? id,
    String? medicineType,
    String? description,
  }) : super(
          id: id,
          medicineType: description,
        );
  factory MedicineTypeMedel.fromJson(Map<String, dynamic> json) =>
      _$MedicineTypeMedelFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineTypeMedelToJson(this);
}
