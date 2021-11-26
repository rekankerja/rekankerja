import 'package:mqtt_client/mqtt_client.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';

PublishSettingAdmin(data) async {
  final builder = MqttClientPayloadBuilder();
  builder.addString('$data');

  if (client.connectionStatus.state == MqttConnectionState.connected)
  client.publishMessage(pubtopic1, MqttQos.exactlyOnce, builder.payload);
}

PublishRekanKerja(data) async {
  final builder = MqttClientPayloadBuilder();
  builder.addString('$data');
  print('$data');
  if (client.connectionStatus.state == MqttConnectionState.connected)
  client.publishMessage(pubtopic2, MqttQos.exactlyOnce, builder.payload);
  print(pubtopic2);
}

PublishRekanKerjaJabatan(data) async {
  final builder = MqttClientPayloadBuilder();
  builder.addString('$data');
  if (client.connectionStatus.state == MqttConnectionState.connected)
  client.publishMessage(pubtopic5, MqttQos.exactlyOnce, builder.payload);
}

PublishRekanKerjaBuzzer(data) async {
  final builder = MqttClientPayloadBuilder();
  builder.addString('$data');
  //print(data);
  if (client.connectionStatus.state == MqttConnectionState.connected)
  client.publishMessage(pubtopic3, MqttQos.exactlyOnce, builder.payload);
}

PublishRekanKerjaBuzzerReport(data) async {
  final builder = MqttClientPayloadBuilder();
  builder.addString('$data');
  //print(data);
  if (client.connectionStatus.state == MqttConnectionState.connected)
    client.publishMessage(pubtopic4, MqttQos.exactlyOnce, builder.payload);
}


