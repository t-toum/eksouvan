import 'package:equatable/equatable.dart';

class Medicine extends Equatable {
  final String? docId;
  final String? medicine;
  final String? description;

  const Medicine({this.docId, this.medicine, this.description});
  @override
  String toString() => medicine ?? '';

  @override
  List<Object?> get props => [docId, medicine, description];
}
