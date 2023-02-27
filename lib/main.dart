import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/bloc_observer.dart';
// ignore_for_file: prefer_const_constructors
import 'app.dart';
import 'dart:async';
import 'package:quotes/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  Bloc.observer = AppBlocObserver();
  runApp(const QuoteApp());
}

