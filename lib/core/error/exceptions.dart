import 'package:equatable/equatable.dart';

abstract class CustomException extends Equatable {
  final String msg;
  const CustomException({required this.msg});
  @override
  List<Object> get props => [msg];
}

class ServerException extends CustomException implements Exception {
  const ServerException({required super.msg});
}

class CacheException implements Exception {
  final String msg;
  CacheException({required this.msg});
}
