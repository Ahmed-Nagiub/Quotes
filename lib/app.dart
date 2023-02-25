import 'package:flutter/material.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/core/utils/app_color.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/core/utils/hex_color.dart';
// ignore_for_file: prefer_const_constructors
import 'config/themes/app_theme.dart';
import 'features/random_quote/presentation/screens/quote_screen.dart';

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      //routes: routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
