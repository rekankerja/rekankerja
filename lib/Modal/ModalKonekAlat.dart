import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import'package:flutter/material.dart';
import 'package:rekankerja/Global/GlobalFunction.dart';
import 'package:rekankerja/Global/GlobalFunctionKoneksiAlat.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';
import 'package:rekankerja/utils/utilityscreen.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ModalKonekAlat extends StatefulWidget {
  @override
  _ModalKonekAlatState createState() => _ModalKonekAlatState();
}

class _ModalKonekAlatState extends State<ModalKonekAlat> {

  StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> results =
  List<BluetoothDiscoveryResult>.empty(growable: true);
  bool isDiscovering = false;
  Timer timer;
  bool isLoading = false;

  final TextEditingController _controller = new TextEditingController();

  List<int> _chunks = [];
  int _contentLength = 0;
  Uint8List _bytes;
  String _base64;

  @override
  void initState() {
    // TODO: implement initState
    _cekBluetooth1stTime();
    super.initState();
  }

  void _startDiscovery() {
    try {
      _streamSubscription =
          FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
            print(r);
            setState(() {
              final existingIndex = results.indexWhere(
                      (element) => element.device.address == r.device.address);
              if (existingIndex >= 0)
                results[existingIndex] = r;
              else
                results.add(r);
            });
          });

      _streamSubscription.onDone(() {
        setState(() {
          isDiscovering = false;
        });
      });
    } catch (er) {
      print(er);
    }
  }

  _cekBluetooth1stTime() async {
    FlutterBluetoothSerial.instance.isEnabled.then((value) {
      if (value == true) {
        _startDiscovery();
      } else {
        FlutterBluetoothSerial.instance.requestEnable().then((value) {
          if (value) {
            _cekBluetooth1stTime();
          }
          // return showDialog<void>(
          //   context: context,
          //   barrierDismissible: false, // user must tap button!
          //   builder: (BuildContext buildContext) {
          //     return WillPopScope(
          //       onWillPop: (){
          //        return forceCloseAlert();
          //       },
          //       child: AlertDialog(
          //         title: const Text('AlertDialog Title'),
          //         content: SingleChildScrollView(
          //           child: ListBody(
          //             children: const <Widget>[
          //               Text('Bluetooth must ON !'),
          //               Text('Please allow turn on bluetooth'),
          //             ],
          //           ),
          //         ),
          //         actions: <Widget>[
          //           TextButton(
          //             child: const Text('TURN ON BLUETOOTH'),
          //             onPressed: (){
          //               FlutterBluetoothSerial.instance.requestEnable();
          //               Navigator.of(buildContext).pop();
          //             },
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // );
        });
      }
    });
  }



  @override
  void dispose() {
    if(_streamSubscription != null)
      _streamSubscription.cancel();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(8),
          right: ScreenUtil().setWidth(8),
          top: ScreenUtil().setHeight(24)),
      height: ScreenUtil.screenHeightDp * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Koneksi Alat',
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Container(
            height: ScreenUtil().setHeight(250),
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (BuildContext context, index) {
                BluetoothDiscoveryResult result = results[index];
                final device = result.device;
                final address = device.address;
                return GestureDetector(
                  onTap: (){
                    connectToDevice(address, device.name).then((value) {
                      print(value);
                      Navigator.pop(context);
                    }).whenComplete(() {
                      setState(() {

                      });
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              device.name ?? '',
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            addresstemp == address ? Text("Connected", style: TextStyle(
                                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700
                            ),) : Container()
                          ],
                        ),
                        Text(
                          address,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),


          // SizedBox(
          //   height: ScreenUtil().setHeight(16),
          // ),
          // GestureDetector(
          //   onTap: () async {
          //
          //   },
          //   child: Container(
          //     alignment: Alignment.center,
          //     height: ScreenUtil().setHeight(36),
          //     width: ScreenUtil.screenWidthDp,
          //     color: Colors.blue,
          //     child: Text(
          //       "Kirim Pesan",
          //       style: TextStyle(
          //           color: Colors.white,
          //           fontSize: ScreenUtil().setSp(20),
          //           fontWeight: FontWeight.w700),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
