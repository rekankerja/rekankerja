import 'package:mqtt_client/mqtt_client.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';

PublishSettingAdmin(data) async {
  final builder = MqttClientPayloadBuilder();
  builder.addString('$data');

  client.publishMessage(pubtopic1, MqttQos.exactlyOnce, builder.payload);
}

PublishRekanKerja(data) async {
  final builder = MqttClientPayloadBuilder();
  builder.addString('$data');

  client.publishMessage(pubtopic2, MqttQos.exactlyOnce, builder.payload);
}

PublishRekanKerjaJabatan(data) async {
  final builder = MqttClientPayloadBuilder();
  builder.addString('$data');

  client.publishMessage(pubtopic5, MqttQos.exactlyOnce, builder.payload);
}


PublishRekanKerjaBuzzer(data) async {
  final builder = MqttClientPayloadBuilder();
  builder.addString('$data');
  print(data);

  client.publishMessage(pubtopic3, MqttQos.exactlyOnce, builder.payload);
}
