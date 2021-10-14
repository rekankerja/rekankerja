import 'package:flutter/material.dart';
import 'package:rekankerja/Class/ClassBuzzer.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';


class PesanMasukWidget extends StatefulWidget {
  @override
  _PesanMasukWidgetState createState() => _PesanMasukWidgetState();
}

class _PesanMasukWidgetState extends State<PesanMasukWidget> {

  List<ClassBuzzer> listpesanmasuk = [];
  bool isLoading = true;

  @override
  void initState() {
    getDataPesanMasuk();
    super.initState();
  }

  getDataPesanMasuk() async {
    final responselog = await db.getReceivePesan();

    for (int _i = 0; _i < responselog.length; _i++) {
      listpesanmasuk.add(ClassBuzzer(
        responselog[_i].uidSender,
        responselog[_i].displayNameSender,
        responselog[_i].urlPhotoSender,
        userLogin2.uid,
        userLogin2.displayName,
        userLogin2.photoURL,
        null,
        responselog[_i].dateTimeReceive,
        responselog[_i].idMessageSender,
        responselog[_i].pesan,
        responselog[_i].isRead,
        null,
        null,



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
      child: isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
          itemCount: listpesanmasuk.length,
          itemBuilder: (context, i){
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
                        child: Image.network(listpesanmasuk[i].photoURLSender),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${listpesanmasuk[i].displayNameSender}", style: TextStyle(
                            fontWeight: FontWeight.w700
                          ),),
                          Text("Diterima pada ${listpesanmasuk[i].dateTimeReceive}", style: TextStyle(
                            fontSize: 12
                          ),),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${listpesanmasuk[i].pesan}",
                      textAlign: TextAlign.start,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 1.0,
                        wordSpacing: 2.0
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(14)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.check, color: Colors.white,),
                              SizedBox(
                                width: 4,
                              ),
                              Text("Konfirmasi", style: TextStyle(
                                color: Colors.white
                              ),),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      })
    );
  }
}
