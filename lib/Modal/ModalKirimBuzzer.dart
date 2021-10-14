import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import 'package:rekankerja/Class/ClassBuzzer.dart';
import 'package:rekankerja/Class/ClassRekanKerja.dart';
import 'package:rekankerja/DbLokal/ModelDbHelper.dart';
import 'package:rekankerja/Global/GlobalFunctionPublishMQTT.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';
import 'package:rekankerja/utils/utilityscreen.dart';

class ModalKirimBuzzer extends StatefulWidget {
  ModalKirimBuzzer({
    @required this.uidReceiver,
    @required this.displayNameReceiver,
    @required this.photoURLReceiver,
  });

  String uidReceiver;
  String displayNameReceiver;
  String photoURLReceiver;

  @override
  _ModalKirimBuzzerState createState() => _ModalKirimBuzzerState();
}

class _ModalKirimBuzzerState extends State<ModalKirimBuzzer> {
  TextEditingController _pesanController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(8),
          right: ScreenUtil().setWidth(8),
          top: ScreenUtil().setHeight(24)),
      height: ScreenUtil.screenHeightDp * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Kirim Pesan',
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: ScreenUtil().setHeight(150),
            //width: ScreenUtil().setWidth(250),
            child: TextField(
              controller: _pesanController,
              maxLength: 254,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                hintText: "Tulis Pesan Anda ..",
                border: InputBorder.none,
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(14)),
                border: Border.all(color: Colors.grey)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Row(
            children: [
            Checkbox(
            checkColor: Colors.white,
            //fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked,
            onChanged: (bool value) {
              setState(() {
                isChecked = value;
              });
            },
          ),
              Text("Gunakan Buzzer")
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(16),
          ),
          GestureDetector(
            onTap: () async {
              DateTime date = await NTP.now();

              List<ClassBuzzer> _temp = [];

              print(widget.photoURLReceiver);

              var logsendpesanhelper = LogSendPesanHelper(
                userLogin2.uid,
                date.toString(),
                null,
                isChecked.toString().toUpperCase(),
                widget.uidReceiver,
                widget.displayNameReceiver,
                widget.photoURLReceiver,
                _pesanController.text,
                "FALSE",
                "FALSE",
              );

              await db.saveLogSendPesan(logsendpesanhelper);

              var _response = await db.getLogSendPesan();

              _temp.add(ClassBuzzer(
                  userLogin2.uid,
                  userLogin2.displayName,
                  userLogin2.photoURL,
                  widget.uidReceiver,
                  widget.displayNameReceiver,
                  widget.photoURLReceiver,
                  date.toString(),
                  null,
                  _response.last.id,
                  _pesanController.text,
                  "FALSE",
                  'FALSE',
                  isChecked.toString().toUpperCase()));

              PublishRekanKerjaBuzzer(json.encode(_temp));
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(36),
              width: ScreenUtil.screenWidthDp,
              color: Colors.blue,
              child: Text(
                "Kirim Pesan",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
    );
  }
}
