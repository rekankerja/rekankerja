import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rekankerja/Class/ClassSettingAdmin.dart';
import 'package:rekankerja/Global/GlobalFunction.dart';
import 'package:rekankerja/Global/GlobalFunctionForeground.dart';
import 'package:rekankerja/Global/GlobalFunctionKoneksiAlat.dart';
import 'package:rekankerja/utils/utilityscreen.dart';
import 'dart:isolate';
import '../Global/GlobalVariable.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import '../main.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> with WidgetsBindingObserver {
  StreamSubscription _locationSubscription;
  Marker marker;
  Marker marker2;
  List<Marker> listOfMarker = [];
  GoogleMapController _controller;
  Location _locationTracker = Location();
  bool firstTime = true;

  @override
  void initState() {
    _getPermission();
    //_initForegroundTask();
    //startForegroundTask();
    WidgetsBinding.instance.addObserver(this);
    addMarker();
    konfirmasiBluetooth();
    super.initState();
  }

  konfirmasiBluetooth() async {
    try{
      setState(() {
        if(connection != null){
          if(connection.isConnected && connection != null){
            print(connection.isConnected);
            userLogin2.alatConnect = "TRUE";
            addresstemp = userLogin2.alatAddress;
            namaAlat = userLogin2.alatNama;
          } else{
            userLogin2.alatConnect = "FALSE";
            userLogin2.alatAddress = null;
            addresstemp = "";
            namaAlat = "";
            connectToDevice(userLogin2.alatAddress, userLogin2.alatNama);
          }
        } else {
          connectToDevice(userLogin2.alatAddress, userLogin2.alatNama);
          // userLogin2.alatConnect = "FALSE";
          // userLogin2.alatAddress = null;
          // addresstemp = "";
          // namaAlat = "";
        }
      });
    }
    catch(er){
      print(er);
    }
  }

  addMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/ic_mapmarker.png");

    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      if (c[0].topic.startsWith("RekanKerja/${userLogin2.referall}")) {
        List listJson = jsonDecode(pt) as List;
        int indexUpdate = listOfMarker
            .indexWhere((element) => element.markerId == listJson[0]["uid"]);
        if (indexUpdate != -1) {
          setState(() {
            listOfMarker[indexUpdate] = Marker(
                infoWindow: InfoWindow(
                  title: "${listJson[0]["displayName"]}",
                  onTap: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text('Info'),
                              content: Container(
                                height: 120,
                                child: Column(
                                  children: [
                                    Text('${listJson[0]["displayName"]}'),
                                    Text('${listJson[0]["workStatus"]}'),
                                  ],
                                ),
                              ),
                            ));
                  },
                ),

                // onTap: (){
                //   showDialog<String>(
                //       context: context,
                //       builder: (BuildContext context) => AlertDialog(
                //     title: Text('Info'),
                //     content: Container(
                //       height: 120,
                //       child: Column(
                //         children: [
                //           Text('${listJson[0]["displayName"]}'),
                //           Text('${listJson[0]["jabatan"]}'),
                //         ],
                //       ),
                //     ),
                //   ));
                // },
                markerId: MarkerId(listJson[0]["uid"]),
                position:
                    LatLng(listJson[0]["latitude"], listJson[0]["longitude"]),
                //rotation: newLocalData.heading,
                draggable: false,
                zIndex: 2,
                flat: true,
                anchor: Offset(0.5, 0.5),
                icon:
                    BitmapDescriptor.fromBytes(byteData.buffer.asUint8List()));
          });
        } else {
          setState(() {
            try {
              listOfMarker.add(Marker(
                  infoWindow:
                      InfoWindow(title: "${listJson[0]["displayName"]}",
                        onTap: () {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text('Info'),
                                content: Container(
                                  height: 120,
                                  child: Column(
                                    children: [
                                      Text('${listJson[0]["displayName"]}'),
                                      Text('${listJson[0]["workStatus"]}'),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ),

                  // onTap: (){
                  //   showDialog<String>(
                  //       context: context,
                  //       builder: (BuildContext context) => AlertDialog(
                  //         title: Text('Info'),
                  //         content: Container(
                  //           height: 120,
                  //           child: Column(
                  //             children: [
                  //               Text('${listJson[0]["displayName"]}'),
                  //               Text('${listJson[0]["jabatan"]}'),
                  //             ],
                  //           ),
                  //         ),
                  //       ));
                  // },
                  markerId: MarkerId(listJson[0]["uid"]),
                  position: LatLng(double.parse(listJson[0]["latitude"]),
                      double.parse(listJson[0]["longitude"])),
                  //rotation: newLocalData.heading,
                  draggable: false,
                  zIndex: 2,
                  flat: true,
                  anchor: Offset(0.5, 0.5),
                  icon: BitmapDescriptor.fromBytes(
                      byteData.buffer.asUint8List())));
            } catch (er) {
              print(er);
            }
          });
        }
      }
      // print(
      //     'Change notification Dari Rekan Kerja Page:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      // print('');
    });
  }

  _initForegroundTask() async {
    // final isitabelsetting = await db.getSettingAdmin();
    //
    // refreshRate = ClassSettingAdmin(
    //     isitabelsetting[7].setting,
    //     isitabelsetting[7].attribut1,
    //     isitabelsetting[7].attribut2,
    //     isitabelsetting[7].attribut3,
    //     isitabelsetting[7].attribut4);

    print("==============${refreshRate.attribut1}");
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'rekanKerjaNotifId',
        channelName: 'Rakan Kerja',
        channelDescription: 'Stay Active and Keep Production',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.HIGH,
        iconData: NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
      ),
      iosNotificationOptions: IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        //interval:  int.parse(refreshRate.attribut1) * 1000,
        interval: 15000,
        autoRunOnBoot: true,
      ),
      printDevLog: true,
    );
  }

  _getPermission() async {
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      try {
        getCurrentLocation();
      } catch (er) {
        print(er);
      }
    }
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/ic_mapmarker.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(
      LocationData newLocalData, Uint8List imageData) async {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    // print(newLocalData.latitude.toString() +
    //     " " +
    //     newLocalData.longitude.toString() +
    //     " " +
    //     DateTime.now().toString());

    SetGPS(newLocalData.latitude.toString(), newLocalData.longitude.toString());

    // setState(() {
    //   marker2 = Marker(
    //       markerId: MarkerId("cust"),
    //       position: LatLng(-7.2341767, 112.7101233),
    //       //rotation: newLocalData.heading,
    //       draggable: false,
    //       zIndex: 2,
    //       flat: true,
    //       anchor: Offset(0.5, 0.5),
    //       icon: BitmapDescriptor.fromBytes(imageData));
    //   marker = Marker(
    //       markerId: MarkerId("home"),
    //       position: latlng,
    //       //rotation: newLocalData.heading, // INI SUPAYA BISA DIPUTAR
    //       draggable: false,
    //       zIndex: 2,
    //       flat: true,
    //       anchor: Offset(0.5, 0.5),
    //       icon: BitmapDescriptor.fromBytes(imageData));
    // });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();
      updateMarkerAndCircle(location, imageData);
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      _locationSubscription =
          _locationTracker.onLocationChanged().listen((newLocalData) {
        if (_controller != null) {
          if (firstTime) {
            _controller.animateCamera(CameraUpdate.newCameraPosition(
                new CameraPosition(
                    bearing: 192.8334901395799,
                    target:
                        LatLng(newLocalData.latitude, newLocalData.longitude),
                    tilt: 0,
                    zoom: 18.00)));
            firstTime = false;
          }
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(-7.2341767, 112.7101233),
    zoom: 14.4746,
  );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    if (state == AppLifecycleState.resumed) {
      _controller.setMapStyle("[]");
    } else if (state == AppLifecycleState.detached) {
      PublishData();
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey,
            height: ScreenUtil().setHeight(300),
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: initialLocation,
              markers: Set.of((listOfMarker != null) ? listOfMarker : []),
              // polylines: Set<Polyline>.of(polylines.values),
              //circles: Set.of((circle != null) ? [circle] : []),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {

                  });
                },
                child: Container(
                    child: Row(
                  children: [
                    Image.asset(
                        userLogin2 != null
                            ? userLogin2.isNotifOn == "TRUE"
                                ? "assets/ic_notifon.png"
                                : "assets/ic_notifoff.png"
                            : "assets/ic_notifoff.png",
                        width: ScreenUtil().setWidth(24)),
                    SizedBox(width: ScreenUtil().setWidth(4)),
                    Text(userLogin2 != null
                        ? userLogin2.isNotifOn == "TRUE"
                            ? "Notifikasi Aktif"
                            : "Notifikasi Non Aktif"
                        : "Notifikasi Non Aktif")
                  ],
                )),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
                                color: userLogin2.alatConnect != "FALSE" ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Text(
                            userLogin2.alatConnect != "FALSE" ? " AKTIF" : " TIDAK AKTIF",
                            style: TextStyle(
                                color: userLogin2.alatConnect != "FALSE" ? Colors.green : Colors.red,
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text("MQTT Status :"),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 4.0),
              //         child: Row(
              //           children: [
              //             Container(
              //               height: 10,
              //               width: 10,
              //               decoration: BoxDecoration(
              //                   color: isMqttConnect ? Colors.green : Colors.red,
              //                   borderRadius: BorderRadius.circular(20)),
              //             ),
              //             Text(
              //               " ${isMqttConnect.toString().toUpperCase()}",
              //               style: TextStyle(color: isMqttConnect ? Colors.green : Colors.red, fontSize: ScreenUtil().setSp(12),
              //                   fontWeight: FontWeight.w700),
              //             )
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),
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
                                color: userLogin2.workStatus == "AKTIF"
                                    ? Colors.green
                                    : userLogin2.workStatus == "ISTIRAHAT"
                                        ? Colors.yellow
                                        : Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Text(
                            " ${userLogin2.workStatus}",
                            style: TextStyle(
                                color: userLogin2.workStatus == "AKTIF"
                                    ? Colors.green
                                    : userLogin2.workStatus == "ISTIRAHAT"
                                        ? Colors.yellow
                                        : Colors.red,
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () async {
              setState(() {

              });
            },
            child: Container(
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(36),
              width: ScreenUtil.screenWidthDp,
              color: Colors.blue,
              child: Text(
                "REFRESH STATUS",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w700),
              ),
            ),
          )





          // Text("Pesan dari Teman Kerja : "),
          // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Row(
          //           children: [
          //             Container(
          //               height: 24,
          //               width: 24,
          //               decoration: BoxDecoration(
          //                   color: Colors.brown,
          //                   borderRadius: BorderRadius.circular(24)),
          //             ),
          //             SizedBox(width: 8),
          //             Text("Nama Karyawan")
          //           ],
          //         ),
          //         SizedBox(height: 12),
          //         Container(
          //           width: MediaQuery.of(context).size.width,
          //           child: Text(
          //             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eu purus sollicitudin, bibendum mauris suscipit, commodo lectus. Nam consequat ultricies leo, aliquam egestas turpis gravida quis. Pellentesque hendrerit ex et velit feugiat, id dapibus nisl",
          //             maxLines: 10,
          //             overflow: TextOverflow.ellipsis,
          //           ),
          //         ),
          //         SizedBox(
          //           height: 8,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             Container(
          //               decoration: BoxDecoration(
          //                   color: Colors.green,
          //                   borderRadius: BorderRadius.circular(4)),
          //               child: Padding(
          //                 padding: const EdgeInsets.all(12.0),
          //                 child: Text("Konfirmasi"),
          //               ),
          //             )
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
