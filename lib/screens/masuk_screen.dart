import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/home_screen.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:SimhegaM/constants/style_constant.dart';
import 'package:get_it/get_it.dart';

class MasukScreen extends StatefulWidget {
  const MasukScreen({Key? key}) : super(key: key);

  @override
  State<MasukScreen> createState() => _MasukScreenState();
}

class _MasukScreenState extends State<MasukScreen> {
  HibahService get service => GetIt.I<HibahService>();

  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mBackgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 60,
                      ),
                      Image.asset(
                        "assets/images/favicon.png",
                        width: 150.0,
                        height: 150.0,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'SI-MHEGA',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'SISTEM INFORMASI MANAJEMEN HIBAH KEAGAMAAN',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldContainer(
                        child: TextField(
                          controller: _user,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.people_alt_outlined,
                              size: 20,
                            ),
                            hintText:
                                'Isikan Nama Pengguna Yang Telah Didaftarkan',
                            labelText: 'Nama Pengguna',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextField(
                          controller: _pass,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.key_outlined,
                              size: 20,
                            ),
                            hintText: 'Isikan Kata Sandi',
                            labelText: 'Kata Sandi',
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
                            if (_user.text == '' || _pass.text == '') {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.ERROR,
                                animType: AnimType.TOPSLIDE,
                                title: 'Maaf',
                                desc: 'Lengkapi Data Terlebih Dahulu',
                                btnOkOnPress: () {},
                              ).show();
                              setState(() {
                                _isLoading = false;
                              });
                            } else {
                              final checkMasuk = CheckMasuk(
                                user: _user.text,
                                pass: _pass.text,
                              );
                              final result = await service.masuk(checkMasuk);
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
                              if (result.error) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: dialog,
                                  animType: AnimType.TOPSLIDE,
                                  title: title,
                                  desc: text!,
                                  btnOkOnPress: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MasukScreen(),
                                      ),
                                    );
                                  },
                                ).show();
                              } else {
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                      token: result.data!.token,
                                      selectedIndex: 0,
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            primary: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 3,
                          ),
                          child: const Text(
                            'MASUK',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
