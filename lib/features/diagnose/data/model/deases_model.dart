import 'package:eksouvan/features/diagnose/domain/entity/deases.dart';
import 'package:json_annotation/json_annotation.dart';
part 'deases_model.g.dart';
@JsonSerializable()
class DeasesModel extends Deases {
  const DeasesModel({
    String? docId,
    String? deases,
    String? description,
  }) : super(docId: docId, deases: deases, description: description);

  factory DeasesModel.fromJson(Map<String, dynamic> json) =>
      _$DeasesModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeasesModelToJson(this);
}
