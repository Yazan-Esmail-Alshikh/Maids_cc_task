import 'dart:convert';

import 'package:maids_cc_task/data/mapper/auth_mapper.dart';
import 'package:maids_cc_task/data/response/auth_response/user_response.dart';
import 'package:maids_cc_task/domain/models/auth_model/user_model.dart';
import 'package:maids_cc_task/domain/models/home_model/todos_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

const String userToken = "user_token";
const String userRefreshToken = "user_refresh_token";
const String user = "user";
const String todoList = "todo_list";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setUserToken(String token) async {
    await _sharedPreferences.setString(userToken, token);
  }

  String getUserToken() {
    return _sharedPreferences.getString(userToken) ?? Constants.empty;
  }

  Future<void> setUserRefreshToken(String token) async {
    await _sharedPreferences.setString(userRefreshToken, token);
  }

  String getUserRefreshToken() {
    return _sharedPreferences.getString(userRefreshToken) ?? Constants.empty;
  }

  Future<void> setUser(UserModel model) async {
    await _sharedPreferences.setString(user, json.encode(model.toJson()));
  }

  UserModel getUser() {
    if (_sharedPreferences.getString(user) == null) {
      return UserResponse().toDomain();
    }
    return UserModel.fromJson(json.decode(_sharedPreferences.getString(user)!));
  }

  Future<void> setTodoList(List<TodoDataModel> todos) async {
    await _sharedPreferences.setStringList(
      todoList,
      todos.map((e) => json.encode(e.toJson())).toList(),
    );
  }

  Future<void> deleteTodoList() async {
    await _sharedPreferences.remove(todoList);
  }

  List<TodoDataModel> getTodoList() {
    if (_sharedPreferences.getStringList(todoList) == null) {
      return [];
    }
    return _sharedPreferences
        .getStringList(todoList)!
        .map((e) => TodoDataModel.fromJson(json.decode(e)))
        .toList();
  }
}
