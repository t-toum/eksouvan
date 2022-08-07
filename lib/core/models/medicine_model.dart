import 'package:eksouvan/core/entities/medicine.dart';
import 'package:json_annotation/json_annotation.dart';
part 'medicine_model.g.dart';

@JsonSerializable()
class MedicineModel extends Medicine {
  const MedicineModel({
    String? docId,
    String? medicine,
    String? description,
  }) : super(docId: docId, medicine: medicine, description: description);

  factory MedicineModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineModelFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineModelToJson(this);
}
