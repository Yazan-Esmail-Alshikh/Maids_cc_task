import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_cc_task/presentation/pages/home/bloc/home_bloc.dart';
import 'package:maids_cc_task/presentation/pages/home/widget/home_app_bar.dart';
import 'package:maids_cc_task/presentation/pages/home/widget/home_floating_button.dart';
import 'package:maids_cc_task/presentation/pages/home/widget/todos_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..add(GetUserFromLocalStorageEvent())
        ..add(GetTodosEvent()),
      child: const Scaffold(
        appBar: HomeAppBar(),
        body: TodosList(),
        floatingActionButton: HomeFloatingButton(),
      ),
    );
  }
}
