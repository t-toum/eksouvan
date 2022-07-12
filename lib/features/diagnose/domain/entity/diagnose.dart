import 'package:equatable/equatable.dart';

class Diagnose extends Equatable {
  final String? diagnoseId;
  final DateTime? diagnoseDate;
  final String? description;
  const Diagnose({this.diagnoseId, this.diagnoseDate, this.description});
  @override
  List<Object?> get props => [diagnoseId, diagnoseDate, description];
}
