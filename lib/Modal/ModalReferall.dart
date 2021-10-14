import 'package:flutter/material.dart';
import 'package:rekankerja/Global/GlobalFunction.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';
import 'package:rekankerja/utils/utilityscreen.dart';

class ModalReferall extends StatefulWidget {
  @override
  _ModalReferallState createState() => _ModalReferallState();
}

class _ModalReferallState extends State<ModalReferall> {
  TextEditingController inputReferall = TextEditingController();


  @override
  void initState() {
    inputReferall.text = userLogin2.referall;
    super.initState();
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
            'Kode Referall',
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              userLogin2.selfReferall,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(64)),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Text(
            "Gunakan Kode Referall perusahaan diatas, untuk disebarkan ke karyawan apabila anda adalah admin. Perlu diingat bahwa 1 perusahaan butuh 1 kode referal saja",
            style: TextStyle(color: Colors.red,
            fontSize: ScreenUtil().setSp(12)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(24),
          ),
          Text(
            "Atau\nTulis referall dari admin perusahaan anda di bawah ini, anda akan kehilangan jabatan ADMIN dan menjadi USER",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(12)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16), vertical: ScreenUtil().setWidth(4)),
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(52),
            width: ScreenUtil.screenWidthDp * 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.7),
            ),
            child: TextField(
              controller: inputReferall,
              maxLength: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(24)
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Text(
            "huruf kapital berpengaruh pada kode referall",
            style: TextStyle(
              color: Colors.red,
                fontSize: ScreenUtil().setSp(12)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(16),
          ),
          GestureDetector(
            onTap: (){
              SetReferall(inputReferall.text).then((value){
                if(value == "sukses"){
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(
                      seconds: 2,
                    ),
                    backgroundColor: Colors.green,
                    content: Text("Sukses Setting Referall"),
                  ));
                }
              });
              // if(inputReferall.text != userLogin2.selfReferall){
              //
              // }
            },
            child: Container(
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(36),
              width: ScreenUtil.screenWidthDp,
              color: Colors.blue,
              child: Text("Set Kode Referall", style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(20),
                fontWeight: FontWeight.w700
              ),),
            ),
          )
        ],
      ),
    );
  }
}
