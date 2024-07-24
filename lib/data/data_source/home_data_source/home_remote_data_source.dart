import 'package:maids_cc_task/data/network/app_api.dart';
import 'package:maids_cc_task/data/network/end_point.dart';
import 'package:maids_cc_task/data/params/home_params/add_new_todo_params.dart';
import 'package:maids_cc_task/data/params/home_params/get_todos_params.dart';
import 'package:maids_cc_task/data/params/home_params/update_todo_params.dart';
import 'package:maids_cc_task/data/response/home_response/todos_response.dart';

abstract class HomeRemoteDataSource {
  Future<TodosResponse> getAllTodos(GetTodosParams params);

  Future<TodoDataResponse> updateTodo(UpdateTodoParams params);

  Future<TodoDataResponse> addNewTodo(AddNewTodoParams params);

  Future<TodoDataResponse> deleteTodo(int id);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final AppServiceClient _appServiceClient;

  HomeRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<TodosResponse> getAllTodos(GetTodosParams params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.todos,
      TodosResponse.fromJson,
      params: params.toJson(),
    );
  }

  @override
  Future<TodoDataResponse> updateTodo(UpdateTodoParams params) async {
    return await _appServiceClient.performPutRequest(
      '${EndPoint.todos}/${params.id}',
      TodoDataResponse.fromJson,
      params: {'completed': params.completed},
    );
  }

  @override
  Future<TodoDataResponse> addNewTodo(AddNewTodoParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.addTodo,
      params.toJson(),
      TodoDataResponse.fromJson,
    );
  }

  @override
  Future<TodoDataResponse> deleteTodo(int id) async {
    return await _appServiceClient.performDeleteRequest(
      '${EndPoint.todos}/$id',
      fromJson: TodoDataResponse.fromJson,
    );
  }
}
