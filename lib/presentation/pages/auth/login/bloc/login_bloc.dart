import 'package:bloc/bloc.dart';
import 'package:maids_cc_task/app/app_pref.dart';
import 'package:maids_cc_task/app/di.dart';
import 'package:maids_cc_task/data/params/auth_params/login_params.dart';
import 'package:maids_cc_task/domain/usecase/auth_use_case/login_use_case.dart';
import 'package:maids_cc_task/presentation/widgets/app_utils.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase = instance<LoginUseCase>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginDataEvent>((event, emit) async {
      emit(LoginLoadingState());
      final result = await _loginUseCase.execute(event.params);
      await result.fold(
        (l) {
          showToast(title: l.message);
          emit(LoginErrorState());
        },
        (r) async {
          await _appPreferences.setUserToken(r.token);
          await _appPreferences.setUserRefreshToken(r.refreshToken);
          await _appPreferences.setUser(r);
          emit(LoginSuccessState());
        },
      );
    });
  }
}
