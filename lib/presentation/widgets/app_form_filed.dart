import 'package:flutter/material.dart';

class AppFormFiled extends StatelessWidget {
  final String? title;
  final String? hint;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final int? lines;

  const AppFormFiled({
    super.key,
    this.title,
    this.hint,
    this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.isPassword = false,
    this.validator,
    this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 15),
        ],
        TextFormField(
          minLines: lines,
          maxLines: lines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: isPassword,
          textInputAction: TextInputAction.next,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
