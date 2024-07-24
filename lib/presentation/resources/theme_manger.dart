import 'package:flutter/material.dart';
import 'package:maids_cc_task/presentation/resources/styles_manger.dart';

import 'color_manger.dart';

ThemeData getApplicationTheme(BuildContext context) => ThemeData(
      useMaterial3: true,
      textTheme: TextTheme(
        bodyLarge: getBoldStyle(color: ColorManger.white, fontSize: 20),
        bodyMedium: getMediumStyle(color: ColorManger.white, fontSize: 16),
        bodySmall: getRegularStyle(color: ColorManger.white, fontSize: 12),
        displayLarge:
            getBoldStyle(color: ColorManger.primaryForAuth, fontSize: 20),
        displayMedium:
            getMediumStyle(color: ColorManger.primaryForAuth, fontSize: 16),
        displaySmall:
            getRegularStyle(color: ColorManger.primaryForAuth, fontSize: 12),
        headlineLarge: getBoldStyle(color: ColorManger.gray, fontSize: 20),
        headlineMedium: getMediumStyle(color: ColorManger.gray, fontSize: 16),
        headlineSmall: getRegularStyle(color: ColorManger.gray, fontSize: 12),
        labelLarge: getBoldStyle(color: ColorManger.black, fontSize: 20),
        labelMedium: getMediumStyle(color: ColorManger.black, fontSize: 16),
        labelSmall: getRegularStyle(color: ColorManger.black, fontSize: 12),
        titleLarge: getBoldStyle(color: ColorManger.lightGray, fontSize: 20),
        titleMedium: getMediumStyle(color: ColorManger.lightGray, fontSize: 16),
        titleSmall: getRegularStyle(color: ColorManger.lightGray, fontSize: 12),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManger.lineColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManger.lineColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManger.lineColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManger.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManger.red),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManger.lineColor),
        ),
        filled: true,
        fillColor: ColorManger.white,
        errorStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: ColorManger.red,
            ),
        hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: 16,
              color: ColorManger.black.withOpacity(0.5),
            ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorManger.primary,
        selectionColor: ColorManger.primary.withOpacity(0.5),
        selectionHandleColor: ColorManger.primary,
      ),
      scaffoldBackgroundColor: ColorManger.fillColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorManger.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        elevation: 0,
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: ColorManger.primary,
        onPrimary: ColorManger.white,
        secondary: ColorManger.primary,
        onSecondary: ColorManger.primary,
        error: ColorManger.red,
        onError: ColorManger.red,
        background: ColorManger.white,
        onBackground: ColorManger.black,
        surface: ColorManger.white,
        onSurface: ColorManger.black,
      ),
    );
