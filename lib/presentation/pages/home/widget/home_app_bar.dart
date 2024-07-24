import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_cc_task/presentation/pages/home/bloc/home_bloc.dart';
import 'package:maids_cc_task/presentation/resources/color_manger.dart';
import 'package:maids_cc_task/presentation/resources/string_manger.dart';
import 'package:maids_cc_task/presentation/widgets/app_image.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final controller = context.watch<HomeBloc>();
        return AppBar(
          title: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManger.primary,
                ),
                child: AppImage(
                  imageUrl: controller.user.image,
                  isCircle: true,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.welcome,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    '${controller.user.firstName} ${controller.user.lastName}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
