

import 'dart:convert';

import 'package:rekankerja/DbLokal/ModelDbHelper.dart';

import 'GlobalFunction.dart';
import 'GlobalVariable.dart';

ListenSettingAdmin(data) async {

  List listJson = jsonDecode(data) as List;
  timer.cancel();
  TimerPublishSettingAdmin();


  var _settinghelper =
  SettingAdmin("HARI KERJA", "SENIN", listJson[0]["attribut2"], listJson[0]["attribut3"], listJson[0]["attribut4"]);
  _settinghelper.setSettingId(1);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper =
      SettingAdmin("HARI KERJA", "SELASA", listJson[1]["attribut2"], listJson[1]["attribut3"], listJson[1]["attribut4"]);
  _settinghelper.setSettingId(2);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper =
      SettingAdmin("HARI KERJA", "RABU", listJson[2]["attribut2"], listJson[2]["attribut3"], listJson[2]["attribut4"]);
  _settinghelper.setSettingId(3);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper =
      SettingAdmin("HARI KERJA", "KAMIS", listJson[3]["attribut2"], listJson[3]["attribut3"], listJson[3]["attribut4"]);
  _settinghelper.setSettingId(4);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper =
      SettingAdmin("HARI KERJA", "JUMAT", listJson[4]["attribut2"], listJson[4]["attribut3"], listJson[4]["attribut4"]);
  _settinghelper.setSettingId(5);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper =
      SettingAdmin("HARI KERJA", "SABTU", listJson[5]["attribut2"], listJson[5]["attribut3"], listJson[5]["attribut4"]);
  _settinghelper.setSettingId(6);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper =
      SettingAdmin("HARI KERJA", "MINGGU", listJson[6]["attribut2"], listJson[6]["attribut3"], listJson[6]["attribut4"]);
  _settinghelper.setSettingId(7);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper = SettingAdmin("REFRESH RATE", listJson[7]["attribut1"], listJson[7]["attribut2"], listJson[7]["attribut3"], listJson[7]["attribut4"]);
  _settinghelper.setSettingId(8);
  await db.updateSettingAdmin(_settinghelper);




}