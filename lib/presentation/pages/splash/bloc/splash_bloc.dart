import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:maids_cc_task/app/app_pref.dart';
import 'package:maids_cc_task/app/di.dart';
import 'package:maids_cc_task/domain/usecase/auth_use_case/get_refresh_token_use_case.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final GetRefreshTokenUseCase _getRefreshTokenUseCase =
      instance<GetRefreshTokenUseCase>();

  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {});
    on<RefreshAuthSession>((event, emit) async {
      if (_appPreferences.getUserRefreshToken().isEmpty) {
        await Future.delayed(const Duration(seconds: 3));
        emit(RefreshSessionErrorState());
        return;
      }
      final result = await _getRefreshTokenUseCase.execute('');
      await result.fold(
        (l) async {
          if (l.code == -6) {
            emit(RefreshSessionSuccessState());
            return;
          }
          emit(RefreshSessionErrorState());
        },
        (r) async {
          await _appPreferences.setUserRefreshToken(r.refreshToken);
          await _appPreferences.setUserToken(r.token);
          emit(RefreshSessionSuccessState());
        },
      );
    });
  }
}
