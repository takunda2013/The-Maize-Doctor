import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maize_doctor/constants/constants.dart';
import 'package:maize_doctor/screens/optiontwousage.dart';
import 'package:maize_doctor/screens/home.dart';
import 'package:maize_doctor/screens/progress_widget.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MaizeDoctor());
}

class MaizeDoctor extends StatelessWidget {
  const MaizeDoctor({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyConstants.toneColor),
      ),
      home: HomeScreen(),
    );
  }
}
