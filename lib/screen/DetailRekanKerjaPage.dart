import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Text(
                        " ${widget.workStatus}",
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return ModalKirimBuzzer();
                  }).whenComplete((){
                setState(() {

                });
              });
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.green,
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
