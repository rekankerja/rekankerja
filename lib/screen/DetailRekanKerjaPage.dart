import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:rekankerja/Global/GlobalFunctionPublishMQTT.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';
import 'package:rekankerja/Modal/ModalKirimBuzzer.dart';

class DetailrekanKerjaPage extends StatefulWidget {
  DetailrekanKerjaPage(
      {@required this.uid,
      @required this.displayName,
      @required this.jabatan,
      @required this.photoURL,
      @required this.workStatus,
      @required this.lastUpdate});

  String uid;
  String displayName;
  String jabatan;
  String photoURL;
  String workStatus;
  String lastUpdate;

  @override
  _DetailrekanKerjaPageState createState() => _DetailrekanKerjaPageState();
}

class _DetailrekanKerjaPageState extends State<DetailrekanKerjaPage> {
  @override
  void initState() {
    ListenPerubahanData();
    super.initState();
  }

  ListenPerubahanData() {
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      if (c[0].topic.startsWith("RekanKerja/${userLogin2.referall}")) {
        //
        List listJson = jsonDecode(pt) as List;

        if (listJson[0]["uid"] == widget.uid) {
          setState(() {
            widget.jabatan = listJson[0]["jabatan"];
            widget.workStatus = listJson[0]["workStatus"];
            widget.lastUpdate = listJson[0]["lastUpdate"];
          }); 
        }
      }
      print(
          'Change notification Dari Rekan Kerja Page:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(left: 12, right: 12, top: 32),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 64,
                    width: 64,
                    child: Image.network(widget.photoURL),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.displayName}"),
                      Text("${widget.jabatan}"),
                      Text("Last Update : ${widget.lastUpdate}")
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Device Status :"),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Text(
                            " Connected",
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Work Status :"),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: widget.workStatus == "AKTIF" ? Colors.green : widget.workStatus == "ISTIRAHAT" ? Colors.yellow : Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Text(
                            " ${widget.workStatus}",
                            style: TextStyle(color: widget.workStatus == "AKTIF" ? Colors.green : widget.workStatus == "ISTIRAHAT" ? Colors.yellow : Colors.red),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              userLogin2.jabatan == "ADMIN"
                  ? GestureDetector(
                      onTap: () {
                        List settingJabatan = [];
                        settingJabatan.add(widget.uid);
                        if (widget.jabatan == "ADMIN") {
                          settingJabatan.add("USER");
                        } else {
                          settingJabatan.add("ADMIN");
                        }

                        PublishRekanKerjaJabatan(settingJabatan);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8)),
                        height: 64,
                        width: MediaQuery.of(context).size.width,
                        child: Text(widget.jabatan == "ADMIN"
                            ? "Ubah Menjadi User"
                            : "Ubah Menjadi Admin"),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  if (widget.workStatus == "ISTIRAHAT") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(
                        seconds: 2,
                      ),
                      backgroundColor: Colors.yellow,
                      content: Text("Karyawan Sedang Istirahat"),
                    ));
                  } else if (widget.workStatus == "TIDAK AKTIF") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(
                        seconds: 2,
                      ),
                      backgroundColor: Colors.red,
                      content: Text("Karyawan Sedang Tidak Aktif"),
                    ));
                  } else {
                    showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return ModalKirimBuzzer(
                            uidReceiver: widget.uid,
                            photoURLReceiver: widget.photoURL,
                            displayNameReceiver: widget.displayName,
                          );
                        }).whenComplete(() {
                      setState(() {});
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: widget.workStatus == "AKTIF"
                          ? Colors.green
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(8)),
                  height: 64,
                  width: MediaQuery.of(context).size.width,
                  child: Text("Kirim Buzzer"),
                ),
              ),
            ],
          )),
    );
  }
}
