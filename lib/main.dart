import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nnfl_project/screens/onboard_screen.dart';
import 'package:nnfl_project/utils/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: persian_blue,
          accentColor: lightening_yellow,
          brightness: Brightness.dark),
      home: OnboardScreen(),
    );
  }
}
