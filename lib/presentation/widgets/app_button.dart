import 'package:flutter/material.dart';
import 'package:maids_cc_task/presentation/resources/color_manger.dart';

class AppButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final double? width;

  const AppButton({super.key, required this.title, this.width, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorManger.white),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
