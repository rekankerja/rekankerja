import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailrekanKerjaPage extends StatefulWidget {
  @override
  _DetailrekanKerjaPageState createState() => _DetailrekanKerjaPageState();
}

class _DetailrekanKerjaPageState extends State<DetailrekanKerjaPage> {
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
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(36)),
                    ),
                    SizedBox(
                        width: 8
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nama Karyawan"),
                        Text("Admin"),
                        Text("Last Update : 24 Sept 2021 11:00:02")
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
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
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            Text(
                              " Connected",
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
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
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            Text(
                              " Active",
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    showModalBottomSheet<void>(
                      isDismissible: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextField(

                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(4)
                                      ),
                                      height: 50,
                                      width: 120,
                                      child: Text("Kirim Buzzer"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    height: 64,
                    width: MediaQuery.of(context).size.width,
                    child: Text("Kirim Buzzer"),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
