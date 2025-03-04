import 'package:creative/presentation/bloc/fetchnews/fetchnews_bloc.dart';
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
          title: 'Aurify',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //theme: Provider.of<ThemeProvider>(context).themeData,
          home: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => FetchnewsBloc(),
              ),
              // BlocProvider(
              //   create: (context) => FetchSpotrateBloc(),
              // ),
            ],
            child: SplashScreen(),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
