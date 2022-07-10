import 'package:eksouvan/core/utils/constants.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final DataStatus dataStatus;
  final String? error;
  final String? uid;
  const LoginState(
      {this.dataStatus = DataStatus.initial, this.error, this.uid});
  @override
  List<Object?> get props => [dataStatus, error, uid];
  LoginState copyWith({
    DataStatus? dataStatus,
    String? error,
    String? uid,
  }) {
    return LoginState(
      dataStatus: dataStatus ?? this.dataStatus,
      error: error ?? this.error,
      uid: uid ?? this.uid,
    );
  }
}
