import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final String? patientId;
  final String? firstname;
  final String? lastname;
  final String? address;
  final String? tel;
  final DateTime? birthday;

  const Patient(
      {this.patientId,
      this.firstname,
      this.lastname,
      this.address,
      this.tel,
      this.birthday});

  @override
  List<Object?> get props => [patientId,firstname,lastname,address,tel,birthday];
}
