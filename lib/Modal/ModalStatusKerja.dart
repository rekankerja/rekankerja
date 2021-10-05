import 'package:flutter/material.dart';
import 'package:rekankerja/Global/GlobalFunction.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';
import 'package:rekankerja/utils/utilityscreen.dart';


class ModalStatusKerja extends StatefulWidget {
  @override
  _ModalStatusKerjaState createState() => _ModalStatusKerjaState();
}

class _ModalStatusKerjaState extends State<ModalStatusKerja> {

  String _tempPilihan = "";

  @override
  void initState() {
    InisiasiTempPilihan();
    super.initState();
  }

  InisiasiTempPilihan() async {
    print("INIT");
    final responselog = await db.getUser();
    setState(() {
      _tempPilihan = responselog[urutanDBLokalUserLogin].workStatus;
    });

    return "sukses";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
      ),
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
            'Status Kerja',
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                _tempPilihan = "AKTIF";
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey)
              ),
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8), vertical: ScreenUtil().setHeight(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Aktif"),
                  _tempPilihan == "AKTIF" ? Icon(Icons.check, color: Colors.green,) : Container()
                ],
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                _tempPilihan = "ISTIRAHAT";
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey)
              ),
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8), vertical: ScreenUtil().setHeight(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Istirahat"),
                  _tempPilihan == "ISTIRAHAT" ? Icon(Icons.check, color: Colors.green,) : Container()
                ],
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                _tempPilihan = "TIDAK AKTIF";
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey)
              ),
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8), vertical: ScreenUtil().setHeight(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tidak Aktif (Cuti, libur, ijin)"),
                  _tempPilihan == "TIDAK AKTIF" ? Icon(Icons.check, color: Colors.green,) : Container()
                ],
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(16),
          ),
          GestureDetector(
            onTap: (){
              SetStatusKerja(_tempPilihan).then((value){
                if(value == "sukses"){
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(
                      seconds: 2,
                    ),
                    backgroundColor: Colors.green,
                    content: Text("Sukses Mengganti Status Kerja"),
                  ));
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(36),
              width: ScreenUtil.screenWidthDp,
              color: Colors.blue,
              child: Text("Atur Status Kerja", style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.w700
              ),),
            ),
          )

        ],
      )
    );
  }
}
