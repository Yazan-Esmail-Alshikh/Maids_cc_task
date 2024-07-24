import 'package:dartz/dartz.dart';
import 'package:maids_cc_task/data/network/failure.dart';
import 'package:maids_cc_task/data/params/home_params/add_new_todo_params.dart';
import 'package:maids_cc_task/domain/models/home_model/todos_model.dart';
import 'package:maids_cc_task/domain/repository/home_repository.dart';
import 'package:maids_cc_task/domain/usecase/base_usecase.dart';

class AddNewTodoUseCase extends BaseUseCase<AddNewTodoParams, TodoDataModel> {
  final HomeRepository _homeRepository;

  AddNewTodoUseCase(this._homeRepository);

  @override
  Future<Either<Failure, TodoDataModel>> execute(
      AddNewTodoParams params) async {
    return await _homeRepository.addNewTodo(params);
  }
}
