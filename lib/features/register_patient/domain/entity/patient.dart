import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';
import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final String? patientId;
  final String? firstname;
  final String? lastname;
  final String? address;
  final String? tel;
  final DateTime? birthday;
  final List<DiagnoseModel?>? diagnoses;

  const Patient({
    this.patientId,
    this.firstname,
    this.lastname,
    this.address,
    this.tel,
    this.birthday,
    this.diagnoses = const [],
  });

  @override
  List<Object?> get props =>
      [patientId, firstname, lastname, address, tel, birthday, diagnoses];
}
