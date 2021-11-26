import 'package:flutter/material.dart';
import 'package:rekankerja/Class/ClassBuzzer.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';

class PesanKeluarWidget extends StatefulWidget {
  @override
  _PesanKeluarWidgetState createState() => _PesanKeluarWidgetState();
}

class _PesanKeluarWidgetState extends State<PesanKeluarWidget> {
  List<ClassBuzzer> listpesankeluar = [];
  bool isLoading = true;

  @override
  void initState() {
    getDataPesanKeluar();
    super.initState();
  }

  getDataPesanKeluar() async {
    final responselog = await db.getLogSendPesan();
    for (int _i = 0; _i < responselog.length; _i++) {
      listpesankeluar.add(ClassBuzzer(
        responselog[_i].uid,
        userLogin2.displayName,
        userLogin2.photoURL,
        responselog[_i].uidTarget,
        responselog[_i].displayNameTarget,
        responselog[_i].urlPhotoTarget,
        responselog[_i].dateTimeSend,
        responselog[_i].dateTimeReceive,
        null,
        responselog[_i].pesan,
        responselog[_i].isRead,
        responselog[_i].isBuzzerReceive,
        responselog[_i].isUseBuzzer,
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 12, left: 12, right: 12),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: listpesankeluar.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => DetailrekanKerjaPage(
                      //         uid: rekanKerja[i].uid,
                      //         displayName: rekanKerja[i].displayName,
                      //         jabatan: rekanKerja[i].jabatan,
                      //         photoURL: rekanKerja[i].photoURL,
                      //         workStatus: rekanKerja[i].workStatus,
                      //         lastUpdate: rekanKerja[i].lastUpdate,
                      //       )),
                      // );
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 32,
                                  width: 32,
                                  child: Image.network(
                                      listpesankeluar[i].photoURLReceiver),
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${listpesankeluar[i].displayNameReceiver}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    // Text(listpesankeluar[i].dateTimeReceive == null ? "Belum Diterima" : "Diterima pada ${listpesankeluar[i].dateTimeReceive}", style: TextStyle(
                                    //     fontSize: 12
                                    // ),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 12),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${listpesankeluar[i].pesan}",
                                textAlign: TextAlign.start,
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.black87,
                                    letterSpacing: 1.0,
                                    wordSpacing: 2.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }));
  }
}
