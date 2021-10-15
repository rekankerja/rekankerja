import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/ui/with_foreground_task.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rekankerja/Class/ClassSettingAdmin.dart';
import 'package:rekankerja/Global/GlobalFunction.dart';
import 'package:rekankerja/Global/GlobalFunctionPublishMQTT.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';
import 'RekanKerjaPage.dart';
import 'PesanPage.dart';
import 'package:rekankerja/screen/loginscreen.dart';
import 'package:rekankerja/utils/signoutproses.dart';

import 'AkunPage.dart';
import 'BerandaPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User _user;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  List<Widget> tabs = [
    BerandaPage(),
    RekanKerjaPage(),
    SettingsPage(),
    AkunPage(),
    // NotifikasiPageBlocProvider(),
  ];

  @override
  void initState() {
    TimerPublishSettingAdmin();
    super.initState();
  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
      child: Scaffold(
          // appBar: AppBar(
          //   // Here we take the value from the MyHomePage object that was created by
          //   // the App.build method, and use it to set our appbar title.
          //   title: Text(widget.title),
          // ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {},
            tooltip: 'Increment',
            child: Icon(Icons.add),
            elevation: 2.0,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Teman Kerja',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Pesan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Akun',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ),
          body: tabs[_selectedIndex]),
    );
  }
}
