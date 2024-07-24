import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_cc_task/presentation/pages/home/bloc/home_bloc.dart';
import 'package:maids_cc_task/presentation/pages/home/widget/add_new_todo_bottom_sheet.dart';
import 'package:maids_cc_task/presentation/resources/color_manger.dart';

class HomeFloatingButton extends StatelessWidget {
  const HomeFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      return GestureDetector(
        onTap: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: ColorManger.fillColor,
          builder: (modalContext) {
            return BlocProvider.value(
              value: BlocProvider.of<HomeBloc>(context),
              child: const AddNewTodoBottomSheet(),
            );
          },
        ),
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: ColorManger.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add,
            color: ColorManger.white,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
