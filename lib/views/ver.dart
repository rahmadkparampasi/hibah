import 'package:flutter/material.dart';
import 'package:hbh/views/home.dart';
import 'package:hbh/views/verD.dart';
import 'package:http/http.dart' as http;
import 'package:hbh/model/MdlVer.dart';
import 'package:hbh/model/api.dart';
import 'dart:async';
import 'dart:convert';

class ver extends StatefulWidget {
  const ver({Key? key}) : super(key: key);

  @override
  _verState createState() => _verState();
}

class _verState extends State<ver> {
  // final String url = "https://hibahsulteng.com/Uslv/getAllUsl";

  var loading = false;

  final list = <VerModel>[];

  var child;

  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _lihatDataVer() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(Uri.parse(Baseurl.lihatpro));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new VerModel(
          api['org_nm'],
          api['usl_nm'],
          api['org_alt'],
          api['usl_tgl'],
          api['usl_id_ex'],
          api['usl_id'],
          api['usl_org'],
          api['usl_lb'],
          api['usl_sls'],
          api['usl_hsl'],
          api['usl_t'],
          api['usl_thn'],
          api['usl_at'],
          api['usl_j'],
          api['usl_pc'],
          api['usl_nmr'],
          api['usl_ttp'],
          api['usl_nhpd'],
          api['usl_nhpdt'],
          api['org_id_ex'],
          api['org_id'],
          api['org_ri'],
          api['org_mail'],
          api['org_desa'],
          api['org_npwp'],
          api['org_hp'],
          api['org_akt'],
          api['org_tgl'],
          api['org_rek'],
        );
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _lihatDataVer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _lihatDataVer,
              key: _refresh,
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];

                  return Container(
                    height: 140,
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) => verD(x))),
                      child: Card(
                        elevation: 14,
                        child: Row(
                          children: <Widget>[
                            //GAMBAR
                            Hero(
                              tag: x.usl_id,
                              child: Container(
                                decoration: BoxDecoration(),
                                padding: EdgeInsets.only(
                                    left: 10, top: 4, bottom: 5),
                                height: 60,
                                width: 60,
                                child: Image(
                                  image:
                                      AssetImage("assets/images/proposal.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            //SPACE
                            SizedBox(
                              width: 10,
                            ),

                            //TEXT LISTVIEW
                            Container(
                              height: 100,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //TEXT NAMA ORGANISASI
                                    Text(
                                      x.org_nm,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    //TEXT NAMA USULAN
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 4),
                                      child: Container(
                                        width: 185,
                                        child: Text(
                                          x.usl_nm,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Color.fromARGB(255, 48, 48, 54),
                                          ),
                                        ),
                                      ),
                                    ),

                                    //TEXT ALAMAT ORGANISASI
                                    Text(
                                      x.org_alt,
                                      style: TextStyle(fontSize: 13),
                                    ),

                                    //TEXT TANGGAL PENGAJUAN
                                    Text(
                                      x.usl_tgl,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //ICON
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
