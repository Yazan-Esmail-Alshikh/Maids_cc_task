import 'package:dartz/dartz.dart';
import 'package:maids_cc_task/data/network/failure.dart';
import 'package:maids_cc_task/data/params/home_params/get_todos_params.dart';
import 'package:maids_cc_task/domain/models/home_model/todos_model.dart';
import 'package:maids_cc_task/domain/repository/home_repository.dart';
import 'package:maids_cc_task/domain/usecase/base_usecase.dart';

class GetAllTodosUseCase extends BaseUseCase<GetTodosParams, TodosModel> {
  final HomeRepository _homeRepository;

  GetAllTodosUseCase(this._homeRepository);

  @override
  Future<Either<Failure, TodosModel>> execute(GetTodosParams params) async {
    return await _homeRepository.getAllTodos(params);
  }
}
