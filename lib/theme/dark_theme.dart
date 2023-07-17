import 'package:flutter/material.dart';

import '../utils/color_resources.dart';

const Color primary = Color(0xFFFFFFFF);

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorResources.primary,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(
                  horizontal: double.infinity, vertical: 60),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorResources.primary))));
