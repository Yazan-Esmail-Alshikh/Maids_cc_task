import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_cc_task/app/function.dart';
import 'package:maids_cc_task/presentation/pages/home/bloc/home_bloc.dart';
import 'package:maids_cc_task/presentation/resources/color_manger.dart';
import 'package:maids_cc_task/presentation/resources/string_manger.dart';
import 'package:maids_cc_task/presentation/widgets/app_button.dart';
import 'package:maids_cc_task/presentation/widgets/app_form_filed.dart';

class AddNewTodoBottomSheet extends StatefulWidget {
  const AddNewTodoBottomSheet({super.key});

  @override
  State<AddNewTodoBottomSheet> createState() => _AddNewTodoBottomSheetState();
}

class _AddNewTodoBottomSheetState extends State<AddNewTodoBottomSheet> {
  final TextEditingController todoController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: ColorManger.fillColor,
        ),
        child: Form(
          key: formKey,
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is AddTodoSuccessState) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              final controller = context.watch<HomeBloc>();
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.addNewTodo,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 20),
                  AppFormFiled(
                    lines: 4,
                    controller: todoController,
                    validator: emptyValid,
                  ),
                  const SizedBox(height: 20),
                  if (state is AddTodoLoadingState)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    AppButton(
                      width: MediaQuery.sizeOf(context).width,
                      title: AppStrings.addTodo,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          controller
                              .add(AddNewTodoEvent(todo: todoController.text));
                        }
                      },
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
