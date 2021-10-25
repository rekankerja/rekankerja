import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rekankerja/Global/GlobalFunction.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';
import 'package:rekankerja/Modal/ModalKonekAlat.dart';
import 'package:rekankerja/Modal/ModalReferall.dart';
import 'package:rekankerja/Modal/ModalSetRefreshRate.dart';
import 'package:rekankerja/Modal/ModalSettingJamKerja.dart';
import 'package:rekankerja/Modal/ModalStatusKerja.dart';
import 'package:rekankerja/utils/signoutproses.dart';
import 'package:rekankerja/utils/utilityscreen.dart';

import 'loginscreen.dart';

class AkunPage extends StatefulWidget {
  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(8),
                right: ScreenUtil().setWidth(8)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              content: Column(children: [
                                Text("App Version : $appVersion"),
                                Text("Build Code : $buildCode"),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("Apa Yang baru ?", style:TextStyle(
                                  fontWeight: FontWeight.w300,
                                )),
                                Text("Improve Maps"),
                                Text("Improve tampilan alert"),
                              ]),
                            ));
                  },
                  child: Container(
                      // height: ScreenUtil().setWidth(164),
                      // width: ScreenUtil().setWidth(164),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(36)),
                      child: Image(
                          image: NetworkImage(
                            "${userLogin2.photoURL}",
                          ),
                          width: ScreenUtil().setWidth(128),
                          height: ScreenUtil().setWidth(128))),
                ),
                Text(
                  "${userLogin2.displayName}",
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(24)),
                ),
                Text(
                  "${userLogin2.jabatan}",
                  style: TextStyle(
                      color: Colors.black87, fontSize: ScreenUtil().setSp(18)),
                ),
                SizedBox(
                  height: 18.0,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return ModalReferall();
                        }).whenComplete(() {
                      setState(() {});
                    });
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/ic_link.png",
                        width: ScreenUtil().setWidth(18),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Kode Referall"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return ModalStatusKerja();
                        });
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/ic_calendar.png",
                        width: ScreenUtil().setWidth(18),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Atur Status Kerja"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                GestureDetector(
                  onTap: () {
                    String _tempisNotifOn;
                    if (userLogin2.isNotifOn == "TRUE") {
                      _tempisNotifOn = "FALSE";
                    } else {
                      _tempisNotifOn = "TRUE";
                    }
                    SetJanganGanggu(_tempisNotifOn).then((value) {
                      if (value == "sukses") {
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(
                            seconds: 2,
                          ),
                          backgroundColor: Colors.green,
                          content: Text("Sukses Setting Mode Jangan Ganggu"),
                        ));
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        userLogin2.isNotifOn == "TRUE"
                            ? "assets/ic_notifon.png"
                            : "assets/ic_notifoff.png",
                        width: ScreenUtil().setWidth(18),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(userLogin2.isNotifOn == "TRUE"
                            ? "Aktifkan Jangan Ganggu"
                            : "Non Aktifkan Jangan Ganggu"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return ModalKonekAlat();
                        }).whenComplete(() {
                      setState(() {});
                    });
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/ic_bluetoothon.png",
                        width: ScreenUtil().setWidth(18),
                      ),
                      addresstemp == "" ? Container(
                        padding: EdgeInsets.all(8.0),
                        child:  Text("Sambungkan Perangkat"),
                      ) : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.only(left: 8.0),
                          //   //padding: EdgeInsets.all(8.0),
                          //   child:  Text("Perangkat Tersambung", style: TextStyle(
                          //     fontWeight: FontWeight.w700
                          //   ),),
                          // ),
                          // Container(
                          //   padding: EdgeInsets.only(left: 8.0),
                          //   //padding: EdgeInsets.all(8.0),
                          //   child:  Text("${userLogin2.alatNama}", style: TextStyle(
                          //       fontWeight: FontWeight.w300
                          //   ),),
                          // )
                          Text(" Perangkat Tersambung", style: TextStyle(
                              fontWeight: FontWeight.w700
                          ),),
                        ],
                      )
                    ],
                  ),
                ),

                /// PEMBATAS ANTARA ADMIN DAN USER BIASA ////////////--------------------------------------------------------------

                userLogin2.jabatan == "ADMIN"
                    ? Column(
                        children: [
                          SizedBox(
                            height: 18.0,
                          ),
                          Container(
                            width: ScreenUtil.screenWidthDp,
                            height: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return ModalSettingJamKerja();
                                  });
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/ic_bussiness.png",
                                  width: ScreenUtil().setWidth(18),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Atur Hari Dan Jam Kerja"),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return ModalSetRefreshRate();
                                  });
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/ic_timer.png",
                                  width: ScreenUtil().setWidth(18),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Atur Refresh Rate"),
                                )
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 8.0,
                          // ),
                          // Row(
                          //   children: [
                          //     Image.asset(
                          //       "assets/ic_holiday.png",
                          //       width: ScreenUtil().setWidth(18),
                          //     ),
                          //     Container(
                          //       padding: EdgeInsets.all(8.0),
                          //       child: Text("Atur hari Libur"),
                          //     )
                          //   ],
                          // ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 16.0,
                ),
                GestureDetector(
                  onTap: () async {
                    await AuthenticationSignOut.signOut(context: context);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/ic_logout.png",
                        width: ScreenUtil().setWidth(18),
                        color: Colors.red,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "LOGOUT",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
