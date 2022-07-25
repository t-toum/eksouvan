import 'package:eksouvan/features/diagnose/data/model/diagnose_model.dart';
import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final String? patientId;
  final String? firstname;
  final String? lastname;
  final String? address;
  final String? tel;
  final DateTime? birthday;
  final String? userId;
  final DateTime? createDate;
  final DateTime? lastUpdate;
  final int? gender;
  final double? height;
  final double? weight;
  final String? congenitalDeases;
  final List<DiagnoseModel>? diagnoses;

  const Patient({
    this.patientId,
    this.firstname,
    this.lastname,
    this.address,
    this.tel,
    this.birthday,
    this.userId,
    this.createDate,
    this.lastUpdate,
    this.gender,
    this.height,
    this.weight,
    this.congenitalDeases,
    this.diagnoses,
  });

  @override
  List<Object?> get props => [
        patientId,
        firstname,
        lastname,
        address,
        tel,
        birthday,
        createDate,
        lastUpdate,
        gender,
        height,
        weight,
        congenitalDeases,
        diagnoses,
      ];
}
