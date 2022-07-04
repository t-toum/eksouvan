import 'package:eksouvan/core/error/exceptions.dart';
import 'package:eksouvan/core/models/todo_model.dart';
import 'package:eksouvan/core/network/network_call.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

abstract class HomeRemoteDatasource {
  Future<List<TodoModel>> getTodos();
}

@LazySingleton(as: HomeRemoteDatasource)
class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  final NetworkCall networkCall;
  final Logger logger;
  HomeRemoteDatasourceImpl({
    required this.logger,
    required this.networkCall,
  });

  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      final response = await networkCall.getTodos();
      logger.i(response);
      return response;
    } catch (e) {
      logger.d(e);
      throw ServerException(msg: e.toString());
    }
  }
}