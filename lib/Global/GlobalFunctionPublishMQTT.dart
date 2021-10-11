import 'package:mqtt_client/mqtt_client.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';

PublishSettingAdmin(data) async {
  final builder = MqttClientPayloadBuilder();
  builder.addString('$data');

  client.publishMessage(pubtopic4, MqttQos.exactlyOnce, builder.payload);
}

PublishRekanKerja(data) async {
  final builder = MqttClientPayloadBuilder();
  builder.addString('$data');

  client.publishMessage(pubtopic5, MqttQos.exactlyOnce, builder.payload);
}
