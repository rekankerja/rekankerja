import 'dart:isolate';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:rekankerja/Global/GlobalFunction.dart';

class FirstTaskHandler implements TaskHandler {
  int updateCount = 0;

  @override
  Future<void> onStart(DateTime timestamp, SendPort sendPort) async {
    // You can use the getData function to get the data you saved.
    final customData = await FlutterForegroundTask.getData<String>(key: 'customData');
    //print('customData: $customData');
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort sendPort) async {
    FlutterForegroundTask.updateService(
        notificationTitle: 'Rekan Kerja',
        notificationText: timestamp.toString());
    //callback: updateCount >= 10 ? updateCallback : null);

    // Send data to the main isolate.
    sendPort?.send(timestamp);
    sendPort?.send(updateCount);
    print("Something " + DateTime.now().toString());
    TestForeGround();

    updateCount++;
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    // You can use the clearAllData function to clear all the stored data.
    await FlutterForegroundTask.clearAllData();
  }
}