import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_cc_task/app/function.dart';
import 'package:maids_cc_task/data/params/auth_params/login_params.dart';
import 'package:maids_cc_task/presentation/pages/auth/login/bloc/login_bloc.dart';
import 'package:maids_cc_task/presentation/resources/routes_manger.dart';
import 'package:maids_cc_task/presentation/resources/string_manger.dart';
import 'package:maids_cc_task/presentation/widgets/app_button.dart';
import 'package:maids_cc_task/presentation/widgets/app_form_filed.dart';
import 'package:maids_cc_task/presentation/widgets/eye_for_password_form_filed.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            AppRoutes.navOfAll(context, routeName: AppRoutes.homeRoute);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.login,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      AppStrings.welcome,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 50),
                    AppFormFiled(
                      controller: nameController,
                      title: AppStrings.userName,
                      hint: AppStrings.enterYourName,
                      validator: emptyValid,
                    ),
                    const SizedBox(height: 30),
                    AppFormFiled(
                      lines: 1,
                      controller: passwordController,
                      title: AppStrings.password,
                      hint: AppStrings.enterYourPassword,
                      isPassword: isPassword,
                      validator: emptyValid,
                      suffixIcon: EyeForPasswordFormFiled(
                        isPassword: isPassword,
                        onTap: onChangedIsPassword,
                      ),
                    ),
                    const SizedBox(height: 50),
                    if (state is LoginLoadingState)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      AppButton(
                        title: AppStrings.login,
                        onTap: () => onTapLogin(context),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  onChangedIsPassword() {
    isPassword = !isPassword;
    setState(() {});
  }

  onTapLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final params = LoginParams(
        password: passwordController.text,
        userName: nameController.text,
        expiresInMins: 30,
      );
      context.read<LoginBloc>().add(LoginDataEvent(params));
    }
  }
}
