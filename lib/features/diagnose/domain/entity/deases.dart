import 'package:equatable/equatable.dart';

class Deases extends Equatable {
  final String? docId;
  final String? deases;
  final String? description;

 const Deases({this.docId, this.deases, this.description});
 
  @override
  List<Object?> get props => [docId,deases,description];
  
}
