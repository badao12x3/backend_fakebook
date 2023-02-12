import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fakebook_frontend/blocs/personal_post/personal_post_bloc.dart';
import 'package:fakebook_frontend/blocs/post_detail/post_detail_bloc.dart';
import 'package:fakebook_frontend/repositories/post_repository.dart';
import 'package:fakebook_frontend/routes.dart';
import 'package:fakebook_frontend/blocs/auth/auth_bloc.dart';
import 'package:fakebook_frontend/blocs/auth/auth_event.dart';
import 'package:fakebook_frontend/blocs/auth/auth_state.dart';
import 'package:fakebook_frontend/configuration.dart';
import 'package:fakebook_frontend/screens/post/emotion_screen.dart';
import 'package:fakebook_frontend/simple_bloc_observer.dart';
import 'package:flutter/material.dart';

import 'package:fakebook_frontend/constants/assets/palette.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/screens.dart';
import 'blocs/post/post_bloc.dart';


void main() async{
  // debug global BLOC, suggesting turn off, please override in debug local BLOC
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    PostRepository postRepository = PostRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          lazy: false,
          create: (_) => AuthBloc()..add(KeepSession())
        ),
        BlocProvider<PostBloc>(
          lazy: false,
          create: (_) => PostBloc(postRepository: postRepository),
        ),
        BlocProvider<PostDetailBloc>(
          lazy: false,
          create: (_) => PostDetailBloc(postRepository: postRepository)
        ),
        BlocProvider<PersonalPostBloc>(
          lazy: false,
          create: (_) => PersonalPostBloc(postRepository: postRepository)
        )
      ],
      child: MaterialApp(
        title: 'Fakebook',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Palette.scaffold
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              switch (state.status) {
                case AuthStatus.unknown:
                  return LoginScreen();
                case AuthStatus.unauthenticated:
                  return LoginScreen();
                case AuthStatus.authenticated:
                  return NavScreen();
              }
            }
        ),
        onGenerateRoute: (settings) {
            switch (settings.name) {
              // case Routes.home_screen:
              //   return MyApp(); // lỗi
              //   break;
              // Bởi vì cập nhật state bằng Bloc nên không cần push từ Login
              case Routes.login_screen:
                return MaterialPageRoute(builder: (_) => LoginScreen());
              case Routes.nav_screen:
                return MaterialPageRoute(builder: (_) => NavScreen());
              case Routes.post_detail_screen: {
                // return MaterialPageRoute(builder: (_) => PostDetailScreen()); // null arguments ???
                final postId = settings.arguments as String;
                return MaterialPageRoute(builder: (_) => PostDetailScreen(postId: postId));
              }
              case Routes.create_post_screen:
                return MaterialPageRoute(builder: (_) => CreatePostScreen());
              case Routes.emotion_screen:
                return MaterialPageRoute(builder: (_) => EmotionScreen());
              default:
                return MaterialPageRoute(builder: (_) => NavScreen());
            }
        }
      ),
    );
  }
}

