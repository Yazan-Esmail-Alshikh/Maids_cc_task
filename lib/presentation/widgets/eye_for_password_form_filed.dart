import 'package:flutter/material.dart';
import 'package:maids_cc_task/presentation/resources/color_manger.dart';

class EyeForPasswordFormFiled extends StatelessWidget {
  final bool isPassword;
  final void Function()? onTap;

  const EyeForPasswordFormFiled(
      {super.key, required this.isPassword, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isPassword ? Icons.visibility : Icons.visibility_off),
      color: ColorManger.primary,
      onPressed: onTap,
    );
  }
}
