


import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:ntp/ntp.dart';
import 'package:rekankerja/Class/ClassAlat.dart';
import 'package:rekankerja/Class/ClassReport.dart';
import 'package:rekankerja/DbLokal/ModelDbHelper.dart';
import 'package:rekankerja/Global/GlobalFunctionPublishMQTT.dart';

import 'GlobalFunction.dart';
import 'GlobalVariable.dart';


void _onDatareceives(Uint8List data) async {

  //print(data);
  //print(String.fromCharCodes(data));

  // {'type':1,'motion':'1','image':0}.
  String dataString = String.fromCharCodes(data);
  dataString = dataString.replaceAll("'", '"');
  //print(dataString);

  Map valueMap = jsonDecode(dataString);



  if(valueMap["type"].toString() == "1"){
    ClassAlat alat = ClassAlat(valueMap["type"].toString(), valueMap["motion"], valueMap["image"].toString(), null, null);
    try{
      userLogin2.isMotion = alat.motion;
      userLogin2.isImage = alat.image;
      final responselog = await db.getUser();
      var userhelper = UserHelper(
          responselog[urutanDBLokalUserLogin].uid,
          responselog[urutanDBLokalUserLogin].email,
          responselog[urutanDBLokalUserLogin].displayName,
          responselog[urutanDBLokalUserLogin].urlPhoto,
          responselog[urutanDBLokalUserLogin].lastLogin,
          responselog[urutanDBLokalUserLogin].jabatan,
          responselog[urutanDBLokalUserLogin].referall,
          responselog[urutanDBLokalUserLogin].selfReferall,
          responselog[urutanDBLokalUserLogin].isNotifOn,
          responselog[urutanDBLokalUserLogin].workStatus,
          responselog[urutanDBLokalUserLogin].keteranganWorkStatus,
          responselog[urutanDBLokalUserLogin].latitude,
          responselog[urutanDBLokalUserLogin].longitude,
          responselog[urutanDBLokalUserLogin].alatConnect,
          responselog[urutanDBLokalUserLogin].alatAddress,
          responselog[urutanDBLokalUserLogin].alatNama,
          userLogin2.isMotion,
          userLogin2.isImage,
          "$appVersion",
          "$buildCode");
      userhelper.setUserId(responselog[urutanDBLokalUserLogin].id);
      await db.updateUser(userhelper);
    }
    catch(er){
      print(er);
    }
  } else {
    ClassAlat alat = ClassAlat(null, null, null, valueMap["id"].toString(), valueMap["sukses"]);

    List<ClassReport> _temp = [];

    DateTime date = await NTP.now();

    _temp.add(
      ClassReport(userLogin2.uid, lastUidSenderMessage, alat.id, date.toString())
    );

    PublishRekanKerjaBuzzerReport(json.encode(_temp));
  }



  // dataString = dataString.replaceAll("'", "");
  // dataString = dataString.replaceAll("{", "");
  // dataString = dataString.replaceAll("}", "");




  //
  // Map map = dataString.
  //
  // dataString.trim();
  //
  // dataString.replaceAll("'", " ");
  // print(dataString);

  //List<ClassAlat> alat = jsonDecode(dataString) as List;

 // print(alat);



}



void sendMessage(String text) async {
  text = text.trim();

  if (text.length > 0) {
    try {
      connection.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
      await connection.output.allSent;
      //print(connection);

      // BluetoothConnection.toAddress(userLogin2.alatAddress).then((_connection) {
      //   try{
      //     _connection.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
      //     // await _connection.output.allSent;
      //     print(_connection);
      //   } catch(er){
      //     print(er);
      //   }




      // setState(() {
      //   messages.add(_Message(clientID, text));
      // });
      //
      // Future.delayed(Duration(milliseconds: 333)).then((_) {
      //   listScrollController.animateTo(
      //       listScrollController.position.maxScrollExtent,
      //       duration: Duration(milliseconds: 333),
      //       curve: Curves.easeOut);
      // });
    } catch (e) {
      // Ignore error, but notify state
      print(e);
    }
  }
}

Future<String> connectToDevice(address, deviceName) async {
  try {
    //print("ADDRESS : " + address);
    connection =
    await BluetoothConnection.toAddress(address);
    namaAlat = deviceName;
    addresstemp = address;
    SetAlatConnect("TRUE", address, deviceName);
    print('Connected to the device');
    // setState(() {
    //
    // });
    connection.input.listen(_onDatareceives).onDone(() {
      SetAlatConnect("FALSE", null, null);
      namaAlat = "";
      addresstemp = "";
      print('Disconnected by remote request');
      // setState(() {
      //
      // });



    });

    return "sukses";
  } catch (exception) {
    print('Cannot connect, exception occured ' + exception.toString());
    return "gagal";
  }
}