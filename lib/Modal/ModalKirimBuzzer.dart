import 'package:flutter/material.dart';
import 'package:rekankerja/utils/utilityscreen.dart';


class ModalKirimBuzzer extends StatefulWidget {
  @override
  _ModalKirimBuzzerState createState() => _ModalKirimBuzzerState();
}

class _ModalKirimBuzzerState extends State<ModalKirimBuzzer> {
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
              border: Border.all(color: Colors.grey)
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(16),
          ),
          GestureDetector(
            onTap: (){
              // SetReferall(inputReferall.text).then((value){
              //   if(value == "sukses"){
              //     Navigator.pop(context);
              //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //       duration: Duration(
              //         seconds: 2,
              //       ),
              //       backgroundColor: Colors.green,
              //       content: Text("Sukses Setting Referall"),
              //     ));
              //   }
              // });
            },
            child: Container(
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(36),
              width: ScreenUtil.screenWidthDp,
              color: Colors.blue,
              child: Text("Kirim Pesan", style: TextStyle(
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
