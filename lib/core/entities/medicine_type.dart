import 'package:equatable/equatable.dart';

class MedicineType extends Equatable {
  final String? id;
  final String? medicineType;
  final String? description;

  const MedicineType({this.id, this.medicineType, this.description});

  @override
  List<Object?> get props => [id,medicineType,description];
}
