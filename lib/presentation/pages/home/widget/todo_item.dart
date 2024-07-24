import 'package:flutter/material.dart';
import 'package:maids_cc_task/domain/models/home_model/todos_model.dart';
import 'package:maids_cc_task/presentation/resources/color_manger.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    required this.model,
    this.onChanged,
    this.onTapDelete,
    super.key,
  });

  final TodoDataModel model;
  final void Function(bool?)? onChanged;
  final void Function()? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorManger.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 24),
        ],
      ),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              model.todo,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onTapDelete,
                icon: const Icon(
                  Icons.delete_outline,
                  color: ColorManger.red,
                ),
              ),
              Checkbox(
                value: model.completed,
                onChanged: onChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
