import 'package:dartz/dartz.dart';
import 'package:maids_cc_task/data/network/failure.dart';
import 'package:maids_cc_task/domain/models/home_model/todos_model.dart';
import 'package:maids_cc_task/domain/repository/home_repository.dart';
import 'package:maids_cc_task/domain/usecase/base_usecase.dart';

class DeleteTodoUseCase extends BaseUseCase<int, TodoDataModel> {
  final HomeRepository _homeRepository;

  DeleteTodoUseCase(this._homeRepository);

  @override
  Future<Either<Failure, TodoDataModel>> execute(int params) async {
    return await _homeRepository.deleteTodo(params);
  }
}
