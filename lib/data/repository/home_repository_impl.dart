import 'package:dartz/dartz.dart';
import 'package:maids_cc_task/app/app_pref.dart';
import 'package:maids_cc_task/data/data_source/home_data_source/home_remote_data_source.dart';
import 'package:maids_cc_task/data/mapper/home_mapper.dart';
import 'package:maids_cc_task/data/network/error_handler.dart';
import 'package:maids_cc_task/data/network/failure.dart';
import 'package:maids_cc_task/data/network/network_info.dart';
import 'package:maids_cc_task/data/params/home_params/add_new_todo_params.dart';
import 'package:maids_cc_task/data/params/home_params/get_todos_params.dart';
import 'package:maids_cc_task/data/params/home_params/update_todo_params.dart';
import 'package:maids_cc_task/domain/models/home_model/todos_model.dart';
import 'package:maids_cc_task/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;
  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepositoryImpl(
    this._homeRemoteDataSource,
    this._appPreferences,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, TodosModel>> getAllTodos(GetTodosParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.getAllTodos(params);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      List<TodoDataModel> todos = _appPreferences.getTodoList();
      return Right(TodosModel(todos: todos, limit: 0, skip: 0, total: 0));
    }
  }

  @override
  Future<Either<Failure, TodoDataModel>> updateTodo(
      UpdateTodoParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.updateTodo(params);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, TodoDataModel>> addNewTodo(
      AddNewTodoParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.addNewTodo(params);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, TodoDataModel>> deleteTodo(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.deleteTodo(params);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
