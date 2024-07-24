import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:maids_cc_task/app/app_pref.dart';
import 'package:maids_cc_task/app/di.dart';
import 'package:maids_cc_task/data/mapper/auth_mapper.dart';
import 'package:maids_cc_task/data/network/network_info.dart';
import 'package:maids_cc_task/data/params/home_params/add_new_todo_params.dart';
import 'package:maids_cc_task/data/params/home_params/get_todos_params.dart';
import 'package:maids_cc_task/data/params/home_params/update_todo_params.dart';
import 'package:maids_cc_task/data/response/auth_response/user_response.dart';
import 'package:maids_cc_task/domain/models/auth_model/user_model.dart';
import 'package:maids_cc_task/domain/models/home_model/todos_model.dart';
import 'package:maids_cc_task/domain/usecase/home_use_case/add_new_todo_use_case.dart';
import 'package:maids_cc_task/domain/usecase/home_use_case/delete_todo_use_case.dart';
import 'package:maids_cc_task/domain/usecase/home_use_case/get_all_todos_use_case.dart';
import 'package:maids_cc_task/domain/usecase/home_use_case/update_todo_use_case.dart';
import 'package:maids_cc_task/presentation/widgets/app_utils.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final GetAllTodosUseCase _allTodosUseCase = instance<GetAllTodosUseCase>();
  final UpdateTodoUseCase _updateTodoUseCase = instance<UpdateTodoUseCase>();
  final AddNewTodoUseCase _addNewTodoUseCase = instance<AddNewTodoUseCase>();
  final DeleteTodoUseCase _deleteTodoUseCase = instance<DeleteTodoUseCase>();
  final NetworkInfo _networkInfo = instance<NetworkInfo>();
  UserModel user = UserResponse().toDomain();
  List<TodoDataModel> todos = [];
  late TodosModel todosModel;
  final ScrollController scrollController = ScrollController();

  HomeBloc() : super(HomeInitial()) {
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (state is! GetTodosPaginateLoadingState) {
          add(GetTodosEvent(isPaginate: true));
        }
      }
    });

    on<HomeEvent>((event, emit) {});

    on<GetUserFromLocalStorageEvent>((event, emit) {
      user = _appPreferences.getUser();
      emit(HomeInitial());
    });

    on<GetTodosEvent>((event, emit) async {
      if (event.isPaginate) {
        emit(GetTodosPaginateLoadingState());
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );
      } else {
        todos.clear();
        emit(GetTodosLoadingState());
      }
      final params = GetTodosParams(skip: 10, limit: 10);
      final result = await _allTodosUseCase.execute(params);
      await result.fold(
        (l) {
          showToast(title: l.message);
          emit(GetTodosErrorState());
        },
        (r) async {
          todosModel = r;
          if (!await _networkInfo.isConnected) {
            todos.clear();
          }
          todos.addAll(r.todos);
          emit(GetTodosSuccessState());
          await _appPreferences.deleteTodoList();
          await _appPreferences.setTodoList(r.todos);
        },
      );
    });

    on<UpdateTodoEvent>((event, emit) async {
      final params = UpdateTodoParams(
        completed: event.params.completed,
        id: event.params.id,
      );
      final result = await _updateTodoUseCase.execute(params);
      result.fold(
        (l) {
          showToast(title: l.message);
          emit(UpdateTodoErrorState());
        },
        (r) {
          todos[event.index].completed = r.completed;
          emit(UpdateTodoSuccessState());
        },
      );
    });

    on<AddNewTodoEvent>((event, emit) async {
      emit(AddTodoLoadingState());
      final params = AddNewTodoParams(
        completed: false,
        todo: event.todo,
        userId: user.id,
      );
      final result = await _addNewTodoUseCase.execute(params);
      result.fold(
        (l) {
          showToast(title: l.message);
          emit(AddTodoErrorState());
        },
        (r) {
          todos.insert(0, r);
          emit(AddTodoSuccessState());
        },
      );
    });

    on<DeleteTodoEvent>((event, emit) async {
      emit(DeleteTodoLoadingState());
      final result = await _deleteTodoUseCase.execute(event.id);
      result.fold(
        (l) {
          showToast(title: l.message);
          emit(DeleteTodoErrorState());
        },
        (r) {
          todos.removeAt(event.index);
          emit(DeleteTodoSuccessState());
        },
      );
    });
  }
}
