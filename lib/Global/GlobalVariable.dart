import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:rekankerja/Class/ClassRekanKerja.dart';
import 'package:rekankerja/Class/ClassSettingAdmin.dart';
import 'package:rekankerja/Class/ClassUserLogin.dart';
import 'package:rekankerja/DbLokal/DbHelper.dart';

/// APP VERSION --

String appVersion = "1.0.0";
String buildCode = "0";

/// -------------------------------------------------------------
/// DATABASE
var db = new DBHelper();
/// =========================================================
/// URL GLOBAL ///=====================================

final client = MqttServerClient('192.168.100.143', '');

/// -------------------------------------------------------------

bool isMqttConnect = false;

User userLogin; // ini untuk data sementara di Firebase saat Login
ClassUserLogin userLogin2; // Ini data untuk UserLogin yang sudah diolah berdasarkan kebutuhan

ClassSettingAdmin refreshRate = ClassSettingAdmin("REFRESH RATE", "5", null, null, null); // Ini data untuk Refresh Rate


List<ClassRekanKerja> rekanKerja = [];
List<ClassSettingAdmin> settingAdminHariKerja = [];
int urutanDBLokalUserLogin;
Timer timer;

String topic = 'RekanKerja/${userLogin2.referall}/#'; /// LIST GLOBAL REKAN KERJA
String topic2 = 'RekanKerjaDetail/${userLogin2.referall}/#'; /// DETAIL REKAN KERJA
String topic3= 'RekanKerjaBuzzer/${userLogin2.referall}/#'; /// BUZZER REKAN KERJA
String topic4 = 'RekanKerjaSetting/${userLogin2.referall}/#'; /// SETTINGAN ADMIN REKAN KERJA

String pubtopic4 = 'RekanKerjaSetting/${userLogin2.referall}/${userLogin2.uid}'; /// PUBLISH ADMIN REKAN KERJA
String pubtopic5 = 'RekanKerja/${userLogin2.referall}/${userLogin2.uid}'; /// PUBLISH DATA REKAN KERJA