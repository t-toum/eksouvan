import 'package:eksouvan/core/utils/constants.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  final DataStatus dataStatus;
  final String? error;
  const LoginState({this.dataStatus=DataStatus.initial,this.error});
  @override
  List<Object?> get props => [dataStatus,error];
  LoginState copyWith({
  DataStatus? dataStatus,
    String? error,
}){
    return LoginState(
      dataStatus: dataStatus?? this.dataStatus,
      error: error ?? this.error
    );
  }

}