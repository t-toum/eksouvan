import 'package:eksouvan/core/models/deases_model.dart';
import 'package:equatable/equatable.dart';

class Diagnose extends Equatable {
  final String? diagnoseId;
  final DateTime? diagnoseDate;
  final String? description;
  final String? user;
  final List<DeasesModel>? deases;
  const Diagnose(
      {this.diagnoseId,
      this.diagnoseDate,
      this.description,
      this.user,
      this.deases});
  @override
  List<Object?> get props => [diagnoseId, diagnoseDate, description, user];
}
