import 'dart:convert';

import 'package:ntp/ntp.dart';
import 'package:rekankerja/Class/ClassRekanKerja.dart';
import 'package:rekankerja/DbLokal/ModelDbHelper.dart';

import 'GlobalFunction.dart';
import 'GlobalFunctionPublishMQTT.dart';
import 'GlobalVariable.dart';

ListenSettingAdmin(data) async {
  List listJson = jsonDecode(data) as List;
  timer.cancel();


  var _settinghelper = SettingAdmin(
      "HARI KERJA",
      "SENIN",
      listJson[0]["attribut2"],
      listJson[0]["attribut3"],
      listJson[0]["attribut4"]);
  _settinghelper.setSettingId(1);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper = SettingAdmin(
      "HARI KERJA",
      "SELASA",
      listJson[1]["attribut2"],
      listJson[1]["attribut3"],
      listJson[1]["attribut4"]);
  _settinghelper.setSettingId(2);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper = SettingAdmin("HARI KERJA", "RABU", listJson[2]["attribut2"],
      listJson[2]["attribut3"], listJson[2]["attribut4"]);
  _settinghelper.setSettingId(3);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper = SettingAdmin("HARI KERJA", "KAMIS", listJson[3]["attribut2"],
      listJson[3]["attribut3"], listJson[3]["attribut4"]);
  _settinghelper.setSettingId(4);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper = SettingAdmin("HARI KERJA", "JUMAT", listJson[4]["attribut2"],
      listJson[4]["attribut3"], listJson[4]["attribut4"]);
  _settinghelper.setSettingId(5);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper = SettingAdmin("HARI KERJA", "SABTU", listJson[5]["attribut2"],
      listJson[5]["attribut3"], listJson[5]["attribut4"]);
  _settinghelper.setSettingId(6);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper = SettingAdmin(
      "HARI KERJA",
      "MINGGU",
      listJson[6]["attribut2"],
      listJson[6]["attribut3"],
      listJson[6]["attribut4"]);
  _settinghelper.setSettingId(7);
  await db.updateSettingAdmin(_settinghelper);
  _settinghelper = SettingAdmin(
      "REFRESH RATE",
      listJson[7]["attribut1"],
      listJson[7]["attribut2"],
      listJson[7]["attribut3"],
      listJson[7]["attribut4"]);
  _settinghelper.setSettingId(8);
  await db.updateSettingAdmin(_settinghelper);


  TimerPublishSettingAdmin();

}

ListenRekanKerja(data) async {

  bool rekanKerjaSudahAda = true;
  final responselog = await db.getRekanKerja();
  List listJson = jsonDecode(data) as List;

  if(responselog.isNotEmpty){
    for (int _i = 0; _i < responselog.length; _i++) {
      /// PENGUJIAN UNTUK APAKAH USER SUDAH PERNAH LOGIN LALU LOGOUT
      if (listJson[0]["uid"] == userLogin2.uid) {
        /// UID diri sendiri, Jangan Ditambahkan Ke DB
        rekanKerjaSudahAda = true;
      } else if(listJson[0]["uid"] == responselog[_i].uid){
        /// UID yang sudah ada jgn ditambahkan ke database
        /// update DB nya

        var rekankerjahelper = RekanKerjaHelper(
            listJson[0]["uid"],
            listJson[0]["email"],
            listJson[0]["displayName"],
            listJson[0]["photoURL"],
            listJson[0]["jabatan"],
            listJson[0]["isNotifOn"],
            listJson[0]["workStatus"],
            listJson[0]["keteranganWorkStatus"],
            listJson[0]["latitude"],
            listJson[0]["longitude"],
            listJson[0]["alatConnect"],
            listJson[0]["lastLogin"],
            listJson[0]["lastUpdate"]);
        rekankerjahelper.setrekankerjaId(listJson[0]["id"]);
        await db.updateRekanKerja(rekankerjahelper);


        rekanKerjaSudahAda = true;
      } else {
        rekanKerjaSudahAda = false;
        break;
      }
    }
  } else {
    if (listJson[0]["uid"] == userLogin2.uid) {
      /// UID diri sendiri, Jangan Ditambahkan Ke DB
      rekanKerjaSudahAda = true;
    } else {
      rekanKerjaSudahAda = false;
    }
  }

  if (rekanKerjaSudahAda == false) {
    /// Apabila belum ada di db, maka tambah rekan kerja

    var rekankerjahelper = RekanKerjaHelper(
        listJson[0]["uid"],
        listJson[0]["email"],
        listJson[0]["displayName"],
        listJson[0]["photoURL"],
        listJson[0]["jabatan"],
        listJson[0]["isNotifOn"],
        listJson[0]["workStatus"],
        listJson[0]["keteranganWorkStatus"],
        listJson[0]["latitude"],
        listJson[0]["longitude"],
        listJson[0]["alatConnect"],
        listJson[0]["lastLogin"],
        listJson[0]["lastUpdate"]);
    await db.saveRekanKerja(rekankerjahelper);

    }
}

ListenRekanKerjaJabatan(data) async {
  //List _data1 = data.toList();
  List _data = json.decode(data);
    if(_data[0] == userLogin2.uid){

      DateTime date = await NTP.now();
      userLogin2.jabatan = _data[1];

      /// Update ke DB
      final responselog = await db.getUser();

      print(urutanDBLokalUserLogin);

      var userhelper = UserHelper(
          responselog[urutanDBLokalUserLogin].uid,
          responselog[urutanDBLokalUserLogin].email,
          responselog[urutanDBLokalUserLogin].displayName,
          responselog[urutanDBLokalUserLogin].urlPhoto,
          responselog[urutanDBLokalUserLogin].lastLogin,
          _data[1],
          responselog[urutanDBLokalUserLogin].referall,
          responselog[urutanDBLokalUserLogin].selfReferall,
          responselog[urutanDBLokalUserLogin].isNotifOn,
          responselog[urutanDBLokalUserLogin].workStatus,
          responselog[urutanDBLokalUserLogin].keteranganWorkStatus,
          responselog[urutanDBLokalUserLogin].latitude,
          responselog[urutanDBLokalUserLogin].longitude,
          "$appVersion",
          "$buildCode");
      userhelper.setUserId(responselog[urutanDBLokalUserLogin].id);
      await db.updateUser(userhelper);

      /// FORCE UNTUK PUBLISH DATA LAGI
      List<ClassRekanKerja> _temp = [];
      _temp.add(ClassRekanKerja(
          responselog[urutanDBLokalUserLogin].uid,
          responselog[urutanDBLokalUserLogin].displayName,
          responselog[urutanDBLokalUserLogin].email,
          responselog[urutanDBLokalUserLogin].urlPhoto,
          null,
          responselog[urutanDBLokalUserLogin].lastLogin,
          _data[1],
          responselog[urutanDBLokalUserLogin].referall,
          responselog[urutanDBLokalUserLogin].selfReferall,
          responselog[urutanDBLokalUserLogin].isNotifOn,
          responselog[urutanDBLokalUserLogin].workStatus,
          responselog[urutanDBLokalUserLogin].keteranganWorkStatus,
          responselog[urutanDBLokalUserLogin].latitude,
          responselog[urutanDBLokalUserLogin].longitude,
          date.toString()));
      PublishRekanKerja(json.encode(_temp));

    }
}

ListenRekanKerjaBuzzer(data) async {

  List listJson = jsonDecode(data) as List;
  DateTime date = await NTP.now();

  if(listJson[0]["uidReceiver"] == userLogin2.uid){
    var receivepesanhelper = LogReceivePesan(
        listJson[0]["uidReceiver"],
        date.toString(),
        listJson[0]["uidSender"],
        listJson[0]["displayNameSender"],
        listJson[0]["pesan"],
        listJson[0]["photoURLSender"],
        listJson[0]["idMessageSender"],
        "FALSE"
    );
    await db.saveReceivePesan(receivepesanhelper);
  }



}
