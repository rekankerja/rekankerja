import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Set Device"),
                    )
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Koneksi Blueetooth Device"),
                    )
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Set Jam Kerja"),
                    )
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Set Libur"),
                    )
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}
