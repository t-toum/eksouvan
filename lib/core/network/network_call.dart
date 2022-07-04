import 'package:dio/dio.dart';
import 'package:eksouvan/core/models/todo_model.dart';
import 'package:eksouvan/core/utils/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'network_call.g.dart';

@RestApi(baseUrl: baseUrl)
@singleton
abstract class NetworkCall {
  @factoryMethod
  factory NetworkCall(Dio dio) = _NetworkCall;
  
  @GET("/todos")
  Future<List<TodoModel>> getTodos();
}
