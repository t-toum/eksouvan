import 'package:eksouvan/core/entities/deases.dart';
import 'package:json_annotation/json_annotation.dart';
part 'deases_model.g.dart';

@JsonSerializable()
class DeasesModel extends Deases {
  const DeasesModel({
    String? deasesId,
    String? deasesname,
  }) : super(deasesId: deasesId, deasesName: deasesname);

  factory DeasesModel.fromJson(Map<String, dynamic> json) =>
      _$DeasesModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeasesModelToJson(this);
}
