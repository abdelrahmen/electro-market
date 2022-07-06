import 'package:electro_market/shared/netwok/remote/dio_helper.dart';
import 'package:electro_market/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: OnBoardingScreen(),
    );
  }
}
