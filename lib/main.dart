import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:rekankerja/DbLokal/DbHelper.dart';
import 'package:rekankerja/screen/loginscreen.dart';

import 'Class/ClassForeground.dart';
import 'screen/HomePage.dart';

void main() {

  runApp(MyApp());

}

void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  FlutterForegroundTask.setTaskHandler(FirstTaskHandler());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rekan Kerja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
    );
  }
}

