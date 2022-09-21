import 'dart:io';
import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/screens/detail_screen.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:SimhegaM/services/hibahcomp_services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class UslGmbrUList extends StatefulWidget {
  final String uslGmbrUsl;
  final String token;
  final String pgnJns;
  final String orgIdEx;
  final String uslNm;
  final String orgNm;
  final int selectedIndexD;
  const UslGmbrUList(
      {super.key,
      required this.uslGmbrUsl,
      required this.uslNm,
      required this.orgNm,
      required this.selectedIndexD,
      required this.token,
      required this.pgnJns,
      required this.orgIdEx});

  @override
  State<UslGmbrUList> createState() => _UslGmbrUListState();
}

class _UslGmbrUListState extends State<UslGmbrUList> {
  String? uslGmbrUsl;

  final TextEditingController _uslGmbrNm = TextEditingController();
  final TextEditingController _uslNm = TextEditingController();
  final TextEditingController _orgNm = TextEditingController();
  File? _image;
  bool _isLoading = false;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      uslGmbrUsl = widget.uslGmbrUsl;
      _uslNm.text = widget.uslNm;
      _orgNm.text = widget.orgNm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dokumentasi Lapangan',
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.grey),
        titleSpacing: 0.0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.all(10),
              child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: ListView(
                  children: <Widget>[
                    const Center(
                      child: Text(
                        'UNGGAH DOKUMENTASI LAPANGAN',
                        style: TextStyle(
                          color: Color(0xFF11249F),
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: _image == null
                                ? const EdgeInsets.all(10)
                                : const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(
                                width: 1,
                              ),
                              borderRadius: _image == null
                                  ? const BorderRadius.all(
                                      Radius.circular(
                                        10,
                                      ),
                                    )
                                  : const BorderRadius.all(
                                      Radius.circular(
                                        0,
                                      ),
                                    ),
                            ),
                            child: Image(
                              width: 150,
                              height: 150,
                              image: _image == null
                                  ? const AssetImage('assets/images/image.png')
                                  : FileImage(_image!) as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 150,
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  final XFile? image = await _picker.pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 50,
                                    maxHeight: 600,
                                    maxWidth: 900,
                                  );
                                  if (image != null) {
                                    setState(() {
                                      _image = File(image.path);
                                    });
                                  }
                                },
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 45,
                                    child: Center(
                                      child: Row(
                                        children: const <Widget>[
                                          Icon(Icons.image),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text('AMBIL FOTO'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          _image != null
                              ? SizedBox(
                                  height: 0,
                                  width: 0,
                                  child: Image.file(_image!),
                                )
                              : Container(),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldContainer(
                            child: TextField(
                              readOnly: true,
                              controller: _uslNm,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.credit_card,
                                  size: 20,
                                ),
                                hintText: 'Isikan Judul Pengusulan',
                                labelText: 'Judul Pengusulan',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldContainer(
                            child: TextField(
                              readOnly: true,
                              controller: _orgNm,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.credit_card,
                                  size: 20,
                                ),
                                hintText: 'Isikan Nama Organisasi',
                                labelText: 'Nama Organisasi',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldContainer(
                            child: TextField(
                              controller: _uslGmbrNm,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.credit_card,
                                  size: 20,
                                ),
                                hintText:
                                    'Isikan Keterangan Gambar Yang Diambil',
                                labelText: 'Keterangan Gambar',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                if (_image == null || _uslGmbrNm.text == '') {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.ERROR,
                                    animType: AnimType.TOPSLIDE,
                                    title: 'Maaf',
                                    desc: 'Lengkapi Data Terlebih Dahulu',
                                    btnOkOnPress: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              super.widget,
                                        ),
                                      );
                                    },
                                  ).show();
                                } else {
                                  final result = await serviceComp.uslGmbrAdd(
                                    uslGmbrUsl!,
                                    _uslGmbrNm.text,
                                    _image!.path,
                                  );
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  final title =
                                      result.error ? 'Maaf' : 'Terima Kasih';
                                  final text = result.error
                                      ? (result.status == 500
                                          ? 'Terjadi Kesalahan'
                                          : result.data?.message)
                                      : result.data?.message;
                                  final dialog = result.dialog;
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: dialog,
                                    animType: AnimType.TOPSLIDE,
                                    title: title,
                                    desc: text!,
                                    btnOkOnPress: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                            uslIdEx: widget.uslGmbrUsl,
                                            orgIdEx: widget.orgIdEx,
                                            token: widget.token,
                                            selectedIndexD:
                                                widget.selectedIndexD,
                                            pgnJns: widget.pgnJns,
                                          ),
                                        ),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                  ).show();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                elevation: 3,
                              ),
                              child: const Text(
                                'SIMPAN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
