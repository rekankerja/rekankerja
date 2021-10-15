import 'dart:isolate';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../main.dart';
import 'GlobalFunction.dart';
import 'GlobalVariable.dart';

ReceivePort _receivePort;

void startForegroundTask() async {
  // You can save data using the saveData function.
  //await FlutterForegroundTask.saveData('customData', 'hello');

  _receivePort = await FlutterForegroundTask.startService(
    notificationTitle: 'Rekan Kerja',
    notificationText: 'Keep Up Your production !',
    callback: startCallback,
  );

  _receivePort?.listen((message) {
    // if (message is DateTime)
    //   print('receive timestamp: $message');
    // else if (message is int)
    //   print('receive updateCount: $message');

  });
}

void stopForegroundTask() {
  FlutterForegroundTask.stopService();
}