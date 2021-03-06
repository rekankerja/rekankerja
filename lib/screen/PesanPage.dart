import 'package:flutter/material.dart';
import 'package:rekankerja/Widget/PesanKeluarWidget.dart';
import 'package:rekankerja/Widget/PesanMasukWidget.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.move_to_inbox), text: "Pesan Masuk",),
                Tab(icon: Icon(Icons.outbox), text: "Pesan Keluar"),
              ],
            ),
            title: const Text('Pesan'),
          ),
          body: TabBarView(
            children: [
              PesanMasukWidget(),
              PesanKeluarWidget()
            ],
          ),
        ),
      ),
    );
  }
}
