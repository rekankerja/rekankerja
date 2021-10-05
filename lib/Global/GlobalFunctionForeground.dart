import 'dart:isolate';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../main.dart';

ReceivePort _receivePort;

void _startForegroundTask() async {
  // You can save data using the saveData function.
  await FlutterForegroundTask.saveData('customData', 'hello');

  _receivePort = await FlutterForegroundTask.startService(
    notificationTitle: 'Foreground Service is running',
    notificationText: 'Tap to return to the app',
    callback: startCallback,
  );

  _receivePort?.listen((message) {
    if (message is DateTime)
      print('receive timestamp: $message');
    else if (message is int)
      print('receive updateCount: $message');
  });
}

void _stopForegroundTask() {
  FlutterForegroundTask.stopService();
}