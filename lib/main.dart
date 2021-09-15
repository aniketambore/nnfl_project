import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nnfl_project/screens/onboard_screen.dart';

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
          primaryColor: Colors.cyan[400],
          accentColor: Colors.deepOrange[200],
          brightness: Brightness.dark),
      home: OnboardScreen(),
    );
  }
}
