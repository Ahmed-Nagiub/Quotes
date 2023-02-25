// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/favourite_quote/presentation/screens/favourite_quote_screen.dart';
import 'package:quotes/features/random_quote/presentation/screens/quote_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String favouriteQuoteRoute = '/favouriteQuote';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((c)=> QuoteScreen()));

      case Routes.favouriteQuoteRoute:
        return MaterialPageRoute(builder: ((c)=> FavouriteQuoteScreen()));

      default:
        return undefinedRoute();
    }
  }


  static Route<dynamic> undefinedRoute(){
    return MaterialPageRoute(
        builder: ((c)=> Scaffold(
      body: Center(
        child: Text(AppStrings.noRouteFound),
      ),
    )));
  }
}