import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fakebook_frontend/configuration.dart';
import 'package:fakebook_frontend/simple_bloc_observer.dart';
import 'package:flutter/material.dart';

import 'package:fakebook_frontend/constants/assets/palette.dart';
import './screens/screens.dart';


void main() async{
  // debug global BLOC, suggesting turn off, please override in debug local BLOC
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fakebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Palette.scaffold
      ),
      home:  LoginScreen()
    );
  }
}

