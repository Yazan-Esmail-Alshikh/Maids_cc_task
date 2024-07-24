import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maids_cc_task/presentation/resources/color_manger.dart';

class AppImage extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String imageUrl;
  final double radius;
  final bool isCircle;

  const AppImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.fit,
    this.height,
    this.radius = 0,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: fit,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: isCircle ? null : BorderRadius.circular(radius),
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              image: DecorationImage(image: imageProvider, fit: fit)),
        );
      },
      errorWidget: (context, url, error) {
        return const Padding(
          padding: EdgeInsets.all(5.0),
          child: Icon(Icons.error_outline, color: ColorManger.red),
        );
      },
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
