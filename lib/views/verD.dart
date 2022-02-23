import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hbh/model/MdlVer.dart';
import 'package:hbh/model/configurasi.dart';
import 'package:http/http.dart';

class verD extends StatefulWidget {
  final VerModel model;
  verD(this.model);

  @override
  _verDState createState() => _verDState();
}

class _verDState extends State<verD> {
  late TextEditingController txtnm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     backgroundColor: Colors.indigoAccent[700],
      //     title: Text(
      //       widget.model.org_nm,
      //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      //     ),

      //     //baru ditambahkan
      //     actions: <Widget>[
      //       IconButton(
      //         icon: Icon(
      //           Icons.search,
      //           color: Colors.white,
      //         ),
      //         onPressed: () {
      //           print("Diklik");
      //         },
      //       ),
      //       IconButton(
      //         icon: Icon(
      //           Icons.notifications,
      //           color: Colors.white,
      //         ),
      //         onPressed: () {
      //           print("Diklik");
      //         },
      //       ),
      //     ]

      //     //batas
      //     ),
      body: Stack(
        children: <Widget>[
          //BODY
          Positioned.fill(
              child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.indigoAccent[700],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          )),

          //APPBAR ICON
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),

          //IMAGE
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: widget.model.usl_id,
                child: Image.asset(
                  'assets/images/proposal.png',
                  height: 200,
                  width: 200,
                ),
              ),
            ),
          ),

          //BOX TITLE
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowList,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Proposal " + widget.model.org_nm,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          //BOX DESKRIPSI
          Align(
            alignment: Alignment(0.0, 0.54),
            child: Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 20),

              child: Expanded(
                child: ListView(
                  children: [
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //BUTTON 1
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new dataPengusul(
                                usl_nm: widget.model.usl_nm,
                                usl_tgl: widget.model.usl_tgl,
                                usl_nmr: widget.model.usl_nmr,
                                org_nm: widget.model.org_nm,
                                org_alt: widget.model.org_alt,
                                org_mail: widget.model.org_mail,
                                org_npwp: widget.model.org_npwp,
                                org_hp: widget.model.org_hp,
                                org_rek: widget.model.org_rek,
                              ),
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 80,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  width: 1.0,
                                  color: Colors.indigoAccent,
                                ),
                              ),
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.indigoAccent,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      "Data Diri Pengusul",
                                    ),
                                    Spacer(
                                      flex: 2,
                                    ),
                                    // Icon(Icons.arrow_drop_down_rounded),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        //BUTTON 2
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const rinAng(),
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 80,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  width: 1.0,
                                  color: Colors.indigoAccent,
                                ),
                              ),
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.monetization_on,
                                      color: Colors.indigoAccent,
                                    ),
                                    // Spacer(),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      "Rincian Anggaran",
                                    ),
                                    Spacer(
                                      flex: 2,
                                    ),
                                    // Icon(Icons.arrow_drop_down_rounded),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     boxShadow: shadowList,
              //     borderRadius: BorderRadius.circular(20)),
            ),
          ),

          //BOX BOTOM
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //BUTTON TOLAK
                  InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text("Tolak Proposal"),
                        content: Text("Anda yakin ingin menolak proposal ini?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(
                              context,
                              [
                                print("Batal ditolak"),
                              ],
                            ),
                            child: Text("Tidak"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(
                              context,
                              [
                                print("Proposal Ditolak"),
                              ],
                            ),
                            child: Text("Ya"),
                          )
                        ],
                      ),
                    ),
                    child: Container(
                      // height: 30,
                      width: 120,
                      // padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.block,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Tolak',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //SPACE BUTTON
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // Spacer(
                  //   flex: 1,
                  // ),
                  //BUTTON VERIFIKASI
                  InkWell(
                    onLongPress: () {
                      print("ditahan");
                    },
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text("Verifikasi Proposal"),
                        content: Text(
                            "Anda yakin ingin memverifikasi proposal ini?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(
                              context,
                              [
                                print("Batal diverifikasi"),
                              ],
                            ),
                            child: Text("Tidak"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(
                              context,
                              [
                                print("Proposal diverifikasi"),
                              ],
                            ),
                            child: Text("Ya"),
                          )
                        ],
                      ),
                    ),
                    child: Container(
                      // height: 30,
                      // padding: EdgeInsets.all(16),
                      width: 180,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Verifikasi',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // DEKORASI BOX BAWAH
              // decoration: BoxDecoration(
              //   color: Colors.grey[200],
              //   borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(40),
              //     topRight: Radius.circular(40),
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

class rinAng extends StatelessWidget {
  const rinAng({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rincian Anggaran"),
        backgroundColor: Colors.indigoAccent,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            alignment: Alignment.topCenter,
            child: Text(
              "Nama Proposal",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          new SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text("No"),
                ),
                DataColumn(
                  label: Text("Uraian"),
                ),
                DataColumn(
                  label: Text("Volume"),
                ),
                DataColumn(
                  label: Text("Satuan"),
                ),
                DataColumn(
                  label: Text("Harga"),
                ),
                DataColumn(
                  label: Text("Total Harga"),
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(
                      Text("1"),
                    ),
                    DataCell(
                      Text("Pasir"),
                    ),
                    DataCell(
                      Text("10"),
                    ),
                    DataCell(
                      Text("Truk"),
                    ),
                    DataCell(
                      Text("Rp. 350.000"),
                    ),
                    DataCell(
                      Text("Rp. 3.500.000"),
                    ),
                  ],
                ),
                //data ke 2
                DataRow(
                  cells: [
                    DataCell(
                      Text("2"),
                    ),
                    DataCell(
                      Text("Pasir"),
                    ),
                    DataCell(
                      Text("10"),
                    ),
                    DataCell(
                      Text("Truk"),
                    ),
                    DataCell(
                      Text("Rp. 350.000"),
                    ),
                    DataCell(
                      Text("Rp. 3.500.000"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Jumlah: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Rp. 121.000.000"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class dataPengusul extends StatefulWidget {
  // const dataPengusul({Key? key}) : super(key: key);
  // final dataPengusul model;
  // dataPengusul(this.model);
  dataPengusul({
    required this.usl_nm,
    required this.usl_tgl,
    required this.usl_nmr,
    required this.org_nm,
    required this.org_alt,
    required this.org_mail,
    required this.org_npwp,
    required this.org_hp,
    required this.org_rek,
  });
  final String usl_nm;
  final String usl_tgl;
  final String usl_nmr;
  final String org_nm;
  final String org_alt;
  final String org_mail;
  final String org_npwp;
  final String org_hp;
  final String org_rek;

  @override
  _dataPengusulState createState() => _dataPengusulState();
}

class _dataPengusulState extends State<dataPengusul> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Pengusul"),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                //Nama Usulan Dokumen
                Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 140,
                          child: Text(
                            "Nama Usulan Dokumen :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            widget.usl_nm,
                            // maxLines: 3,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        // Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ),
                ),

                //Tanggal Dokumen
                Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 140,
                          child: Text(
                            "Tanggal Pengusulan :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            widget.usl_tgl,
                            // maxLines: 3,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        // Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ),
                ),

                //Nomor Usulan
                Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 140,
                          child: Text(
                            "Nomor Usulan Dokumen :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            widget.usl_nmr,
                            // maxLines: 3,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        // Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ),
                ),

                //Nama Organisasi
                Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 140,
                          child: Text(
                            "Nama Organisasi :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            widget.org_nm,
                            // maxLines: 3,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        // Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ),
                ),

                //Alamat
                Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 140,
                          child: Text(
                            "Alamat :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            widget.org_alt,
                            // maxLines: 3,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        // Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ),
                ),

                //Email
                Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 140,
                          child: Text(
                            "Email :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            widget.org_mail,
                            // maxLines: 3,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        // Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ),
                ),

                //NPWP
                Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 140,
                          child: Text(
                            "NPWP :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            widget.org_npwp,
                            // maxLines: 3,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        // Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ),
                ),

                //HP
                Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 140,
                          child: Text(
                            "Nomor HP :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            widget.org_hp,
                            // maxLines: 3,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        // Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ),
                ),

                //Nomor Rekening
                Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 140,
                          child: Text(
                            "Nomor Rekening :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            widget.org_rek,
                            // maxLines: 3,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        // Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
