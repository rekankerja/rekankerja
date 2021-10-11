import 'package:flutter/material.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';
import 'DetailRekanKerjaPage.dart';

class RekanKerjaPage extends StatefulWidget {
  @override
  _RekanKerjaPageState createState() => _RekanKerjaPageState();
}

class _RekanKerjaPageState extends State<RekanKerjaPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, top: 24),
      child: ListView.builder(
          itemCount: rekanKerja.length,
          itemBuilder: (context, i){
        return GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailrekanKerjaPage()),
            );
          },
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(24)),
                      ),
                      SizedBox(
                        width: 8
                      ),
                      Text("${rekanKerja[i].displayName}")
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Text(
                        " Device Status : Active",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Text(
                        " Work Status : ${rekanKerja[i].workStatus}",
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                  Text("Last Update : 24 Sept 2021 10:36:20")
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
