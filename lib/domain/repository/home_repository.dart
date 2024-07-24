import 'package:dartz/dartz.dart';
import 'package:maids_cc_task/data/network/failure.dart';
import 'package:maids_cc_task/data/params/home_params/add_new_todo_params.dart';
import 'package:maids_cc_task/data/params/home_params/get_todos_params.dart';
import 'package:maids_cc_task/data/params/home_params/update_todo_params.dart';
import 'package:maids_cc_task/domain/models/home_model/todos_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, TodosModel>> getAllTodos(GetTodosParams params);

  Future<Either<Failure, TodoDataModel>> updateTodo(UpdateTodoParams params);

  Future<Either<Failure, TodoDataModel>> addNewTodo(AddNewTodoParams params);

  Future<Either<Failure, TodoDataModel>> deleteTodo(int params);
}
