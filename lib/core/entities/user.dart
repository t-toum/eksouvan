import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? name;
  final String? username;
  final String? password;
  final String? docId;
  final String? role;

  const User({this.name, this.username, this.password, this.docId,this.role});

  @override
  List<Object?> get props => [name, username, password, docId,role];
}
