import 'package:maids_cc_task/app/constants.dart';
import 'package:maids_cc_task/data/response/home_response/todos_response.dart';
import 'package:maids_cc_task/domain/models/home_model/todos_model.dart';

extension TodosMapper on TodosResponse? {
  TodosModel toDomain() {
    return TodosModel(
      total: this?.total ?? Constants.zero,
      limit: this?.limit ?? Constants.zero,
      skip: this?.skip ?? Constants.zero,
      todos: this?.todos != null
          ? this!.todos!.map((e) => e.toDomain()).toList()
          : [],
    );
  }
}

extension TodoDataMapper on TodoDataResponse? {
  TodoDataModel toDomain() {
    return TodoDataModel(
      completed: this?.completed ?? false,
      id: this?.id ?? Constants.zero,
      todo: this?.todo ?? Constants.empty,
      userId: this?.userId ?? Constants.zero,
    );
  }
}
