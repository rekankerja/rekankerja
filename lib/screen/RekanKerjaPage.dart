import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:rekankerja/Class/ClassRekanKerja.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';
import 'DetailRekanKerjaPage.dart';

class RekanKerjaPage extends StatefulWidget {
  @override
  _RekanKerjaPageState createState() => _RekanKerjaPageState();
}

class _RekanKerjaPageState extends State<RekanKerjaPage> {
  List<ClassRekanKerja> rekanKerja = [];
  bool isLoading = true;

  @override
  void initState() {
    getRekanKerjaFromDB();
    ListenPerubahanData();
    super.initState();
  }

  getRekanKerjaFromDB() async {
    final responselog = await db.getRekanKerja();
    for (int _i = 0; _i < responselog.length; _i++) {
      rekanKerja.add(ClassRekanKerja(
          responselog[_i].uid,
          responselog[_i].displayName,
          responselog[_i].email,
          responselog[_i].urlPhoto,
          null,
          responselog[_i].lastLogin,
          responselog[_i].jabatan,
          null,
          null,
          responselog[_i].isNotifOn,
          "TIDAK AKTIF",//responselog[_i].workStatus,
          "",//responselog[_i].keteranganWorkStatus,
          "FALSE",//responselog[_i].alatConnect,
          "FALSE",//responselog[_i].isMotion,
          "FALSE",//responselog[_i].isImage,
          responselog[_i].latitude,
          responselog[_i].longitude,
          responselog[_i].lastUpdate));
    }
    setState(() {
      isLoading = false;
    });
  }

  ListenPerubahanData() {
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      if (c[0].topic.startsWith("RekanKerja/${userLogin2.referall}")) {
        //
        List listJson = jsonDecode(pt) as List;

        int indexUpdate = rekanKerja
            .indexWhere((element) => element.uid == listJson[0]["uid"]);
        if(indexUpdate != -1){
            rekanKerja[indexUpdate] = ClassRekanKerja(
                listJson[0]["uid"],
                listJson[0]["displayName"],
                listJson[0]["email"],
                listJson[0]["photoURL"],
                listJson[0]["createDate"],
                listJson[0]["lastSignIn"],
                listJson[0]["jabatan"],
                listJson[0]["referall"],
                listJson[0]["selfReferall"],
                listJson[0]["isNotifOn"],
                listJson[0]["workStatus"],
                listJson[0]["keteranganWorkStatus"],
                listJson[0]["alatConnect"],
                listJson[0]["isMotion"],
                listJson[0]["isImage"],
                listJson[0]["latitude"],
                listJson[0]["longitude"],
                listJson[0]["lastUpdate"]);
        } else {
            if(listJson[0]["uid"] != userLogin2.uid){
              rekanKerja.add(ClassRekanKerja(
                  listJson[0]["uid"],
                  listJson[0]["displayName"],
                  listJson[0]["email"],
                  listJson[0]["photoURL"],
                  listJson[0]["createDate"],
                  listJson[0]["lastSignIn"],
                  listJson[0]["jabatan"],
                  listJson[0]["referall"],
                  listJson[0]["selfReferall"],
                  listJson[0]["isNotifOn"],
                  listJson[0]["workStatus"],
                  listJson[0]["keteranganWorkStatus"],
                  listJson[0]["alatConnect"],
                  listJson[0]["isMotion"],
                  listJson[0]["isImage"],
                  listJson[0]["latitude"],
                  listJson[0]["longitude"],
                  listJson[0]["lastUpdate"]));
            }

        }
      }
      setState(() {
        print(rekanKerja[0]);
      });
      // print(
      //     'Change notification Dari Rekan Kerja Page:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      // print('');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, top: 24),
      child: isLoading == false
          ? ListView.builder(
              itemCount: rekanKerja.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailrekanKerjaPage(
                                uid: rekanKerja[i].uid,
                                displayName: rekanKerja[i].displayName,
                                jabatan: rekanKerja[i].jabatan,
                                photoURL: rekanKerja[i].photoURL,
                                workStatus: rekanKerja[i].workStatus,
                                lastUpdate: rekanKerja[i].lastUpdate,
                              )),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                child: rekanKerja[i].photoURL != null ? Image.network(rekanKerja[i].photoURL) : Container(),
                              ),
                              SizedBox(width: 8),
                              Text("${rekanKerja[i].displayName}")
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: rekanKerja[i].alatConnect == "TRUE" ? Colors.green : Colors.red,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              Text(
                                " Device Status : ${rekanKerja[i].alatConnect}",
                                style: TextStyle(color: rekanKerja[i].alatConnect == "TRUE" ? Colors.green : Colors.red),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: rekanKerja[i].workStatus == "AKTIF" ? Colors.green : rekanKerja[i].workStatus == "ISTIRAHAT" ? Colors.yellow : Colors.red,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              Text(
                                " Work Status : ${rekanKerja[i].workStatus}",
                                style: TextStyle(color: rekanKerja[i].workStatus == "AKTIF" ? Colors.green : rekanKerja[i].workStatus == "ISTIRAHAT" ? Colors.yellow : Colors.red),
                              )
                            ],
                          ),
                          Text("Last Update : ${Jiffy(rekanKerja[i].lastUpdate).format("dd-MMM-yyyy HH:mm")}")
                        ],
                      ),
                    ),
                  ),
                );
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}
