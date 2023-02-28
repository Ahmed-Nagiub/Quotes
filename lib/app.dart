import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/config/locale/app_localizations_setup.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/core/utils/app_color.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/core/utils/hex_color.dart';
import 'package:quotes/features/splash/presentation/cubit/locale_cubit.dart';
// ignore_for_file: prefer_const_constructors
import 'config/themes/app_theme.dart';
import 'features/random_quote/presentation/screens/quote_screen.dart';
import 'injection_container.dart' as di;
class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<LocaleCubit>()),
      ],
      child: BlocBuilder<LocaleCubit,LocaleState>(
        buildWhen: (previousState, currentState) {
          return previousState!= currentState;
        },
        builder: (context,state) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: appTheme(),
            //routes: routes,
            locale: state.locale,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
          );
        }
      ),
    );
  }
}
