import 'package:flutter/material.dart';
import 'package:rekankerja/DbLokal/ModelDbHelper.dart';
import 'package:rekankerja/Global/GlobalFunction.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';
import 'package:rekankerja/utils/utilityscreen.dart';

class ModalSettingJamKerja extends StatefulWidget {
  @override
  _ModalSettingJamKerjaState createState() => _ModalSettingJamKerjaState();
}

class _ModalSettingJamKerjaState extends State<ModalSettingJamKerja> {
  List<SettingAdmin> settinghariKerja = [];
  bool isLoading = true;

  @override
  void initState() {
    getDataHariKerja();
    super.initState();
  }

  getDataHariKerja() async {
    isLoading = true;
    final responseHariKerja = await db.getSettingAdminHariKerja();
    setState(() {
      for (int _i = 0; _i < responseHariKerja.length; _i++) {
        settinghariKerja.add(SettingAdmin(
            responseHariKerja[_i].setting,
            responseHariKerja[_i].attribut1,
            responseHariKerja[_i].attribut2,
            responseHariKerja[_i].attribut3,
            responseHariKerja[_i].attribut4));
      }

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(8),
            right: ScreenUtil().setWidth(8),
            top: ScreenUtil().setHeight(48)),
        height: ScreenUtil.screenHeightDp,
        child: isLoading ?  Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 8,
              ),
              Text("Loading .. ")
            ],
          )
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Setting Hari Kerja dan Jam Kerja',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Senin',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  //fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: settinghariKerja[0].attribut4 == "TRUE",
                  onChanged: (bool value) {
                    setState(() {
                      settinghariKerja[0] = SettingAdmin(
                          settinghariKerja[0].setting,
                          settinghariKerja[0].attribut1,
                          settinghariKerja[0].attribut2,
                          settinghariKerja[0].attribut3,
                          value.toString().toUpperCase());
                    });
                  },
                ),
              ],
            ),
            settinghariKerja[0].attribut4 == "TRUE"
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[0].attribut2 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[0]
                              .attribut2
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[0]
                              .attribut2
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[0] = SettingAdmin(
                            settinghariKerja[0].setting,
                            settinghariKerja[0].attribut1,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[0].attribut3,
                            settinghariKerja[0].attribut4);
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[0].attribut2 != null
                        ? settinghariKerja[0].attribut2
                        : "00:00"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[0].attribut3 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[0]
                              .attribut3
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[0]
                              .attribut3
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[0] = SettingAdmin(
                            settinghariKerja[0].setting,
                            settinghariKerja[0].attribut1,
                            settinghariKerja[0].attribut2,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[0].attribut4
                        );
                        print(value.hour.toString());
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[0].attribut3 != null
                        ? settinghariKerja[0].attribut3
                        : "00:00"),
                  ),
                )
              ],
            )
                : Container(),
            SizedBox(
              height: ScreenUtil().setHeight(8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selasa',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  //fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: settinghariKerja[1].attribut4 == "TRUE",
                  onChanged: (bool value) {
                    setState(() {
                      settinghariKerja[1] = SettingAdmin(
                          settinghariKerja[1].setting,
                          settinghariKerja[1].attribut1,
                          settinghariKerja[1].attribut2,
                          settinghariKerja[1].attribut3,
                          value.toString().toUpperCase());
                    });
                  },
                ),
              ],
            ),
            settinghariKerja[1]
                .attribut4 == "TRUE"
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[1].attribut2 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[1]
                              .attribut2
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[1]
                              .attribut2
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[1] = SettingAdmin(
                            settinghariKerja[1].setting,
                            settinghariKerja[1].attribut1,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[1].attribut3,
                            settinghariKerja[1].attribut4);
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[1].attribut2 != null
                        ? settinghariKerja[1].attribut2
                        : "00:00"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[1].attribut3 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[1]
                              .attribut3
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[1]
                              .attribut3
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[1] = SettingAdmin(
                            settinghariKerja[1].setting,
                            settinghariKerja[1].attribut1,
                            settinghariKerja[1].attribut2,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[1].attribut4
                        );
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[1].attribut3 != null
                        ? settinghariKerja[1].attribut3
                        : "00:00"),
                  ),
                )
              ],
            )
                : Container(),
            SizedBox(
              height: ScreenUtil().setHeight(8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rabu',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  //fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: settinghariKerja[2].attribut4 == 'TRUE',
                  onChanged: (bool value) {
                    setState(() {
                      settinghariKerja[2] = SettingAdmin(
                          settinghariKerja[2].setting,
                          settinghariKerja[2].attribut1,
                          settinghariKerja[2].attribut2,
                          settinghariKerja[2].attribut3,
                          value.toString().toUpperCase());
                    });
                  },
                ),
              ],
            ),
            settinghariKerja[2].attribut4 == "TRUE"
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[2].attribut2 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[2]
                              .attribut2
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[2]
                              .attribut2
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[2] = SettingAdmin(
                            settinghariKerja[2].setting,
                            settinghariKerja[2].attribut1,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[2].attribut3,
                            settinghariKerja[2].attribut4);
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[2].attribut2 != null
                        ? settinghariKerja[2].attribut2
                        : "00:00"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[2].attribut3 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[2]
                              .attribut3
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[2]
                              .attribut3
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[2] = SettingAdmin(
                            settinghariKerja[2].setting,
                            settinghariKerja[2].attribut1,
                            settinghariKerja[2].attribut2,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[2].attribut4
                        );
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[2].attribut3 != null
                        ? settinghariKerja[2].attribut3
                        : "00:00"),
                  ),
                )
              ],
            )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kamis',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  //fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: settinghariKerja[3].attribut4 == "TRUE",
                  onChanged: (bool value) {
                    setState(() {
                      settinghariKerja[3] = SettingAdmin(
                          settinghariKerja[3].setting,
                          settinghariKerja[3].attribut1,
                          settinghariKerja[3].attribut2,
                          settinghariKerja[3].attribut3,
                          value.toString().toUpperCase());
                    });
                  },
                ),
              ],
            ),
            settinghariKerja[3]
                .attribut4 == "TRUE"
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[3].attribut2 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[3]
                              .attribut2
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[3]
                              .attribut2
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[3] = SettingAdmin(
                            settinghariKerja[3].setting,
                            settinghariKerja[3].attribut1,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[3].attribut3,
                            settinghariKerja[3].attribut4);
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[3].attribut2 != null
                        ? settinghariKerja[3].attribut2
                        : "00:00"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[3].attribut3 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[3]
                              .attribut3
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[3]
                              .attribut3
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[3] = SettingAdmin(
                            settinghariKerja[3].setting,
                            settinghariKerja[3].attribut1,
                            settinghariKerja[3].attribut2,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[3].attribut4
                        );
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[3].attribut3 != null
                        ? settinghariKerja[3].attribut3
                        : "00:00"),
                  ),
                )
              ],
            )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jumat',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  //fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: settinghariKerja[4].attribut4 == "TRUE",
                  onChanged: (bool value) {
                    setState(() {
                      settinghariKerja[4] = SettingAdmin(
                          settinghariKerja[4].setting,
                          settinghariKerja[4].attribut1,
                          settinghariKerja[4].attribut2,
                          settinghariKerja[4].attribut3,
                          value.toString().toUpperCase());
                    });
                  },
                ),
              ],
            ),
            settinghariKerja[4].attribut4 == "TRUE"
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[4].attribut2 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[4]
                              .attribut2
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[4]
                              .attribut2
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[4] = SettingAdmin(
                            settinghariKerja[4].setting,
                            settinghariKerja[4].attribut1,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[4].attribut3,
                            settinghariKerja[4].attribut4);
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[4].attribut2 != null
                        ? settinghariKerja[4].attribut2
                        : "00:00"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[4].attribut3 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[4]
                              .attribut3
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[4]
                              .attribut3
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[4] = SettingAdmin(
                            settinghariKerja[4].setting,
                            settinghariKerja[4].attribut1,
                            settinghariKerja[4].attribut2,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[4].attribut4
                        );
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[4].attribut3 != null
                        ? settinghariKerja[4].attribut3
                        : "00:00"),
                  ),
                )
              ],
            )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sabtu',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  //fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: settinghariKerja[5].attribut4 == "TRUE",
                  onChanged: (bool value) {
                    setState(() {
                      settinghariKerja[5] = SettingAdmin(
                          settinghariKerja[5].setting,
                          settinghariKerja[5].attribut1,
                          settinghariKerja[5].attribut2,
                          settinghariKerja[5].attribut3,
                          value.toString().toUpperCase());
                    });
                  },
                ),
              ],
            ),
            settinghariKerja[5].attribut4 == "TRUE"
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[5].attribut2 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[5]
                              .attribut2
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[5]
                              .attribut2
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[5] = SettingAdmin(
                            settinghariKerja[5].setting,
                            settinghariKerja[5].attribut1,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[5].attribut3,
                            settinghariKerja[5].attribut4);
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[5].attribut2 != null
                        ? settinghariKerja[5].attribut2
                        : "00:00"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[5].attribut3 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[5]
                              .attribut3
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[5]
                              .attribut3
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[5] = SettingAdmin(
                            settinghariKerja[5].setting,
                            settinghariKerja[5].attribut1,
                            settinghariKerja[5].attribut2,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[5].attribut4
                        );
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[5].attribut3 != null
                        ? settinghariKerja[5].attribut3
                        : "00:00"),
                  ),
                )
              ],
            )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Minggu',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  //fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: settinghariKerja[6].attribut4 == "TRUE",
                  onChanged: (bool value) {
                    setState(() {
                      settinghariKerja[6] = SettingAdmin(
                          settinghariKerja[6].setting,
                          settinghariKerja[6].attribut1,
                          settinghariKerja[6].attribut2,
                          settinghariKerja[6].attribut3,
                          value.toString().toUpperCase());
                    });
                  },
                ),
              ],
            ),
            settinghariKerja[6].attribut4 == "TRUE"
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[6].attribut2 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[6]
                              .attribut2
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[6]
                              .attribut2
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[6] = SettingAdmin(
                            settinghariKerja[6].setting,
                            settinghariKerja[6].attribut1,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[6].attribut3,
                            settinghariKerja[6].attribut4);
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[6].attribut2 != null
                        ? settinghariKerja[6].attribut2
                        : "00:00"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: settinghariKerja[6].attribut3 != null
                          ? TimeOfDay(
                          hour: int.parse(settinghariKerja[6]
                              .attribut3
                              .substring(0, 2)
                              .toString()),
                          minute: int.parse(settinghariKerja[6]
                              .attribut3
                              .substring(4, 5)
                              .toString()))
                          : TimeOfDay(hour: 00, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    ).then((value) {
                      String _temp;
                      String _tempminute;
                      if(value.hour > 9){
                        _temp = value.hour.toString();
                      } else {
                        _temp = "0"+value.hour.toString();
                      }
                      if(value.minute > 9){
                        _tempminute = value.minute.toString();
                      } else {
                        _tempminute = "0"+value.minute.toString();
                      }
                      setState(() {
                        settinghariKerja[6] = SettingAdmin(
                            settinghariKerja[6].setting,
                            settinghariKerja[6].attribut1,
                            settinghariKerja[6].attribut2,
                            _temp +
                                ":" +
                                _tempminute,
                            settinghariKerja[6].attribut4
                        );
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil.screenWidthDp * 0.45,
                    child: Text(settinghariKerja[6].attribut3 != null
                        ? settinghariKerja[6].attribut3
                        : "00:00"),
                  ),
                )
              ],
            )
                : Container(),
            SizedBox(
              height: ScreenUtil().setHeight(8),
            ),
            GestureDetector(
              onTap: () {
                SetHariKerja(settinghariKerja).then((value){
                  if(value == "sukses"){
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(
                        seconds: 2,
                      ),
                      backgroundColor: Colors.green,
                      content: Text("Sukses Mengganti Hari Kerja"),
                    ));
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(36),
                width: ScreenUtil.screenWidthDp,
                color: Colors.blue,
                child: Text(
                  "Atur Hari Kerja ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ));
  }
}
