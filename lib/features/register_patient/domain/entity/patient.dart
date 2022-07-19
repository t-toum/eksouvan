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
  final DateTime? updateDate;
  final int? gender;
  final double? height;
  final double? weight;
  final String? congenitalDeases;

  const Patient(
      {this.patientId,
      this.firstname,
      this.lastname,
      this.address,
      this.tel,
      this.birthday,
      this.userId,
      this.createDate,
      this.updateDate,
      this.gender,
      this.height,
      this.weight,
      this.congenitalDeases});

  @override
  List<Object?> get props => [
        patientId,
        firstname,
        lastname,
        address,
        tel,
        birthday,
        createDate,
        updateDate,
        gender,
        height,
        weight,
        congenitalDeases
      ];
}
