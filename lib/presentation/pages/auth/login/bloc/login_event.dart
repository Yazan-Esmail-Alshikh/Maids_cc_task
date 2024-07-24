part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginDataEvent extends LoginEvent {
  final LoginParams params;

  LoginDataEvent(this.params);
}
