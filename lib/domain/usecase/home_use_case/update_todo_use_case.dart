import 'package:dartz/dartz.dart';
import 'package:maids_cc_task/data/network/failure.dart';
import 'package:maids_cc_task/data/params/home_params/update_todo_params.dart';
import 'package:maids_cc_task/domain/models/home_model/todos_model.dart';
import 'package:maids_cc_task/domain/repository/home_repository.dart';
import 'package:maids_cc_task/domain/usecase/base_usecase.dart';

class UpdateTodoUseCase extends BaseUseCase<UpdateTodoParams, TodoDataModel> {
  final HomeRepository _homeRepository;

  UpdateTodoUseCase(this._homeRepository);

  @override
  Future<Either<Failure, TodoDataModel>> execute(
      UpdateTodoParams params) async {
    return await _homeRepository.updateTodo(params);
  }
}
