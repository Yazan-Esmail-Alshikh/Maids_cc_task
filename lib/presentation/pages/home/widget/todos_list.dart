import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_cc_task/data/params/home_params/update_todo_params.dart';
import 'package:maids_cc_task/presentation/pages/home/bloc/home_bloc.dart';
import 'package:maids_cc_task/presentation/resources/color_manger.dart';
import 'package:maids_cc_task/presentation/resources/string_manger.dart';
import 'package:maids_cc_task/presentation/widgets/app_button.dart';

import 'add_new_todo_bottom_sheet.dart';
import 'todo_item.dart';

class TodosList extends StatelessWidget {
  const TodosList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final controller = context.watch<HomeBloc>();
        if (state is GetTodosLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: RefreshIndicator(
              onRefresh: () async => controller.add(GetTodosEvent()),
              child: CustomScrollView(
                clipBehavior: Clip.none,
                controller: controller.scrollController,
                slivers: [
                  if (controller.todos.isEmpty)
                    SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.noDataYet,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 30),
                          AppButton(
                            title: AppStrings.addNewTodo,
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
                            width: MediaQuery.sizeOf(context).width,
                          )
                        ],
                      ),
                    )
                  else
                    SliverList.separated(
                      itemBuilder: (context, index) {
                        if (state is GetTodosPaginateLoadingState) {
                          if (index == controller.todos.length) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                        return TodoItem(
                          model: controller.todos[index],
                          onChanged: (value) => controller.add(
                            UpdateTodoEvent(
                              index: index,
                              params: UpdateTodoParams(
                                id: controller.todos[index].id,
                                completed: value ?? false,
                              ),
                            ),
                          ),
                          onTapDelete: () => controller.add(
                            DeleteTodoEvent(
                                id: controller.todos[index].id, index: index),
                          ),
                        );
                      },
                      itemCount: state is GetTodosPaginateLoadingState
                          ? controller.todos.length + 1
                          : controller.todos.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                    )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
