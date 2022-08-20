import 'package:equatable/equatable.dart';

class Medicine extends Equatable {
  final String? docId;
  final String? medicine;
  final String? description;
  final String? type;

  const Medicine({this.docId, this.medicine, this.description,this.type});
  @override
  String toString() => medicine ?? '';

  @override
  List<Object?> get props => [docId, medicine, description,type];
}
