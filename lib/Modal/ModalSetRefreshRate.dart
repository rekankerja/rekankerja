import 'package:flutter/material.dart';
import 'package:rekankerja/DbLokal/ModelDbHelper.dart';
import 'package:rekankerja/Global/GlobalFunction.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';
import 'package:rekankerja/utils/utilityscreen.dart';

class ModalSetRefreshRate extends StatefulWidget {
  @override
  _ModalSetRefreshRateState createState() => _ModalSetRefreshRateState();
}

class _ModalSetRefreshRateState extends State<ModalSetRefreshRate> {
  TextEditingController inputRefreshRate = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<SettingAdmin> _refreshRate = [];
  bool _isLoading = true;

  @override
  void initState() {
    getDataRefreshRate();
    super.initState();
  }

  getDataRefreshRate() async {
    _isLoading = true;
    final responseHariKerja = await db.getSettingAdminRefreshRate();
    setState(() {
      _refreshRate.add(SettingAdmin(
          responseHariKerja[0].setting,
          responseHariKerja[0].attribut1,
          responseHariKerja[0].attribut2,
          responseHariKerja[0].attribut3,
          responseHariKerja[0].attribut4));

      inputRefreshRate.text = responseHariKerja[0].attribut1;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(8),
          right: ScreenUtil().setWidth(8),
          top: ScreenUtil().setHeight(24)),
      height: ScreenUtil.screenHeightDp * 0.6,
      child: _isLoading
          ? Container(
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
              ))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Set Refresh Rate',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(8),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(16),
                            vertical: ScreenUtil().setWidth(4)),
                        alignment: Alignment.center,
                        height: ScreenUtil().setHeight(52),
                        width: ScreenUtil.screenWidthDp * 0.75,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: inputRefreshRate,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isNotEmpty) {
                              if (int.parse(value) < 1) {
                                return "Angka tidak boleh minus / 0";
                              } else if (int.parse(value) > 30) {
                                return "Masukkan angka antara 0 hingga 30";
                              } else {
                                return null;
                              }
                            } else {
                              return "Harus Diisi";
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(8),
                    ),
                    Text("Detik")
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(16),
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.pop(context);
                      print("VALID ============");
                      SetRefreshRate(inputRefreshRate.text).then((value) {
                        if (value == "sukses") {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(
                              seconds: 2,
                            ),
                            backgroundColor: Colors.green,
                            content: Text("Sukses Setting Refresh Rate"),
                          ));
                        }
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(36),
                    width: ScreenUtil.screenWidthDp,
                    color: Colors.blue,
                    child: Text(
                      "Set Refresh Rate",
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
