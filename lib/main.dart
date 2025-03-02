import 'package:creative/presentation/bloc/authentication/login/fetchnews/fetchnews_bloc.dart';
import 'package:creative/presentation/screeens/authentication/forgot_password_screen.dart';
import 'package:creative/presentation/screeens/authentication/login_screen.dart';
import 'package:creative/presentation/screeens/bottom_navigation.dart';
import 'package:creative/presentation/screeens/home_screen.dart';
import 'package:creative/presentation/screeens/market_data.dart';
import 'package:creative/presentation/screeens/news_screen.dart';
import 'package:creative/presentation/screeens/profile_screen.dart';
import 'package:creative/presentation/screeens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 802),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Creative',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //theme: Provider.of<ThemeProvider>(context).themeData,
          home: BlocProvider(
            create: (context) => FetchnewsBloc(),
            child: ProfileScreen(),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
