import 'dart:io';
import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/models/hibahpost_model.dart';
import 'package:SimhegaM/screens/detail_screen.dart';
import 'package:SimhegaM/screens/detaila_screen.dart';
import 'package:SimhegaM/screens/items/func_item.dart';
import 'package:SimhegaM/screens/items/sp_icon.dart';
import 'package:SimhegaM/screens/masuk_screen.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:SimhegaM/services/hibahcomp_services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class DetailItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final bool isLast;
  const DetailItem({
    Key? key,
    required this.subtitle,
    required this.icon,
    required this.title,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 68,
          child: ListTile(
            minLeadingWidth: 0,
            leading: SizedBox(
              height: double.infinity,
              child: SPIcon(assetName: icon),
            ),
            title: Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        isLast ? Container() : const Divider()
      ],
    );
  }
}

class ButtonDT extends StatelessWidget {
  final String text;
  const ButtonDT({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () async {
          final Uri launcUri = Uri(scheme: 'tel', path: text);
          if (await canLaunchUrl(launcUri)) {
            await launchUrl(launcUri);
          }
        },
        child: Text(text),
      ),
    );
  }
}

class ButtonDTP extends StatelessWidget {
  final IconButton child;
  const ButtonDTP({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        color: Colors.blue,
        shape: CircleBorder(),
      ),
      width: 38,
      height: 38,
      child: child,
    );
  }
}

class CompBottomUslT extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  const CompBottomUslT({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomUslT> createState() => _CompBottomUslTState();
}

class _CompBottomUslTState extends State<CompBottomUslT> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
  String? pgnJns;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
      pgnJns = widget.pgnJns;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            'Jenis Bantuan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            showBottomModal(
              context,
              CompBottomUslTThn(
                uslT: '1',
                icon: 'rupiah.png',
                uslIdEx: uslIdEx!,
                orgIdEx: orgIdEx!,
                selectedIndex: selectedIndex!,
                token: token!,
                pgnJns: pgnJns!,
              ),
              350,
            );
          },
          minLeadingWidth: 0,
          leading: const SizedBox(
            height: double.infinity,
            child: SPIcon(assetName: 'rupiah.png'),
          ),
          title: const Text(
            'Uang',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            showBottomModal(
              context,
              CompBottomUslTThn(
                uslT: '2',
                icon: 'boxes.png',
                uslIdEx: uslIdEx!,
                orgIdEx: orgIdEx!,
                selectedIndex: selectedIndex!,
                token: token!,
                pgnJns: pgnJns!,
              ),
              350,
            );
          },
          minLeadingWidth: 0,
          leading: const SizedBox(
            height: double.infinity,
            child: SPIcon(assetName: 'boxes.png'),
          ),
          title: const Text(
            'Barang',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ],
    );
  }
}

class CompBottomUslTThn extends StatefulWidget {
  final String uslT;
  final String icon;
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  const CompBottomUslTThn({
    super.key,
    required this.uslT,
    required this.icon,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomUslTThn> createState() => _CompBottomUslTThnState();
}

class _CompBottomUslTThnState extends State<CompBottomUslTThn> {
  String uslTT = 'Bantuan Uang';
  String icon = 'rupiah.png';
  String? uslT;
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
  String? pgnJns;

  HibahService get service => GetIt.I<HibahService>();

  final TextEditingController uslThn = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      uslT = widget.uslT;
      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
      pgnJns = widget.pgnJns;
      if (widget.uslT == "2") {
        uslTT = "Bantuan Barang";
        icon = widget.icon;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            'Jenis Bantuan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: () {},
          minLeadingWidth: 0,
          leading: SizedBox(
            height: double.infinity,
            child: SPIcon(assetName: icon),
          ),
          title: const Text(
            'Jenis Bantuan',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
          subtitle: Text(
            uslTT,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        const Divider(),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextFieldContainer(
            child: TextField(
              controller: uslThn,
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                ),
                labelText: 'Tahun Anggaran',
                labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showBottomModal(
                        context,
                        CompBottomUslT(
                          uslIdEx: uslIdEx!,
                          orgIdEx: orgIdEx!,
                          selectedIndex: selectedIndex!,
                          token: token!,
                          pgnJns: pgnJns!,
                        ),
                        200);
                  },
                  child: const Text('KEMBALI'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (ctx) => FullScreenLoader(),
                    );
                    if (uslThn.text == '' || uslIdEx == null || uslT == null) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.TOPSLIDE,
                        title: 'Maaf',
                        desc: 'Lengkapi Data Terlebih Dahulu',
                        btnOkOnPress: () => Navigator.pop(context),
                      ).show();
                    } else {
                      final changeUslT = ChangeUslT(
                          uslIdEx: uslIdEx!, uslT: uslT!, uslThn: uslThn.text);
                      final result = await service.changeUslT(changeUslT);
                      Navigator.pop(context);
                      final title = result.error ? 'Maaf' : 'Terima Kasih';
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
                            Navigator.pop(context);
                          },
                        ).show();
                      } else {
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
                                  uslIdEx: uslIdEx!,
                                  orgIdEx: orgIdEx!,
                                  token: token!,
                                  selectedIndex: selectedIndex!,
                                  pgnJns: pgnJns!,
                                ),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ).show();
                      }
                    }
                  },
                  child: const Text('SIMPAN'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CompBottomUslVer extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  const CompBottomUslVer({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomUslVer> createState() => _CompBottomUslVerState();
}

class _CompBottomUslVerState extends State<CompBottomUslVer> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
  String? pgnJns;
  HibahService get service => GetIt.I<HibahService>();

  APIResponseHibah<List<PgwForList>>? _apiResponsePgw;

  bool _isLoading = false;
  bool _isError = false;

  String errorMessage = 'Terjadi Masalah, Silahkan Muat Kembali';

  @override
  void initState() {
    super.initState();
    _fetchPgw();
    setState(() {
      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
      pgnJns = widget.pgnJns;
      _isLoading = false;
    });
  }

  _fetchPgw() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponsePgw = await service.getPgwListPage();
    setState(() {
      if (_apiResponsePgw!.error) {
        _isError = true;
        _isLoading = false;
        errorMessage = _apiResponsePgw!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _isError
            ? Center(
                child: Column(
                  children: <Widget>[
                    const Text('Terjadi Masalah, Silahkan Muat Kembali'),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Muat Kembali',
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: (_, index) {
                  return Column(
                    children: <Widget>[
                      Card(
                        elevation: 0,
                        child: ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            showBottomModal(
                              context,
                              CompBottomUslVerP(
                                uslVerUsl: uslIdEx!,
                                orgIdEx: orgIdEx!,
                                selectedIndex: selectedIndex!,
                                token: token!,
                                pgwNm: _apiResponsePgw!.data![index].pgwNm,
                                uslVerPgw:
                                    _apiResponsePgw!.data![index].pgwIdEx,
                                pgwGol: _apiResponsePgw!.data![index].pgwGol,
                                pgwJbt: _apiResponsePgw!.data![index].pgwJbt,
                                pgwNip: _apiResponsePgw!.data![index].pgwNip,
                                pgnJns: pgnJns!,
                              ),
                              300,
                            );
                          },
                          minLeadingWidth: 0,
                          leading: CircleAvatar(
                            child: Text(
                              _apiResponsePgw!.data![index].no.toString(),
                            ),
                          ),
                          title: Text(
                            '${_apiResponsePgw!.data![index].pgwNm} - ${_apiResponsePgw!.data![index].pgwJbt}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            '${_apiResponsePgw!.data![index].pgwNip} - ${_apiResponsePgw!.data![index].pgwGol}',
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
                itemCount:
                    _apiResponsePgw == null ? 0 : _apiResponsePgw!.data!.length,
              );
  }
}

class CompBottomUslVerP extends StatefulWidget {
  final String uslVerUsl;
  final String uslVerPgw;
  final String pgwNm;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  final String pgwJbt;
  final String pgwNip;
  final String pgwGol;
  const CompBottomUslVerP({
    super.key,
    required this.uslVerUsl,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
    required this.pgwNm,
    required this.uslVerPgw,
    required this.pgwGol,
    required this.pgwJbt,
    required this.pgwNip,
  });

  @override
  State<CompBottomUslVerP> createState() => _CompBottomUslVerPState();
}

class _CompBottomUslVerPState extends State<CompBottomUslVerP> {
  String? uslVerUsl;
  String? uslVerPgw;
  String? pgwNm;
  String? pgwJbt;
  String? pgwGol;
  String? pgwNip;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
  String? pgnJns;

  HibahService get service => GetIt.I<HibahService>();

  String? uslVerP;

  @override
  void initState() {
    super.initState();
    setState(() {
      uslVerUsl = widget.uslVerUsl;
      uslVerPgw = widget.uslVerPgw;
      orgIdEx = widget.orgIdEx;
      pgwNm = widget.pgwNm;
      pgwJbt = widget.pgwJbt;
      pgwGol = widget.pgwGol;
      pgwNip = widget.pgwNip;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
      pgnJns = widget.pgnJns;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            'Kategori Verifikator',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: () {},
          minLeadingWidth: 0,
          leading: const SizedBox(
            height: double.infinity,
            child: SPIcon(assetName: 'rating.png'),
          ),
          title: Text(
            '${pgwNm!} - ${pgwJbt!}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            '${pgwNip!} - ${pgwGol!}',
          ),
        ),
        const Divider(),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextFieldContainer(
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                prefixIcon: Icon(
                  Icons.sync,
                  size: 20,
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: '1',
                  child: Text('Ketua'),
                ),
                DropdownMenuItem(
                  value: '2',
                  child: Text('Sekretaris'),
                ),
                DropdownMenuItem(
                  value: '0',
                  child: Text('Anggota'),
                ),
              ],
              hint: const Text(
                "PILIH SALAH SATU KATEGORI VERIFIKASI",
                style: TextStyle(fontSize: 15),
              ),
              value: uslVerP,
              onChanged: (value) {
                setState(() {
                  uslVerP = value as String?;
                });
              },
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showBottomModal(
                      context,
                      CompBottomUslVer(
                        uslIdEx: uslVerUsl!,
                        orgIdEx: orgIdEx!,
                        selectedIndex: selectedIndex!,
                        token: token!,
                        pgnJns: pgnJns!,
                      ),
                      250,
                    );
                  },
                  child: const Text('KEMBALI'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (ctx) => FullScreenLoader(),
                    );
                    if (uslVerUsl == null ||
                        uslVerPgw == null ||
                        uslVerP == null ||
                        uslVerP == '') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.TOPSLIDE,
                        title: 'Maaf',
                        desc: 'Lengkapi Data Terlebih Dahulu',
                        btnOkOnPress: () => Navigator.pop(context),
                      ).show();
                    } else {
                      final insertUslVer = InsertUslVer(
                          uslVerUsl: uslVerUsl!,
                          uslVerPgw: uslVerPgw!,
                          uslVerP: uslVerP!);
                      final result = await service.insertUslVer(insertUslVer);
                      Navigator.pop(context);
                      final title = result.error ? 'Maaf' : 'Terima Kasih';
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
                            Navigator.pop(context);
                          },
                        ).show();
                      } else {
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
                                  uslIdEx: uslVerUsl!,
                                  orgIdEx: orgIdEx!,
                                  token: token!,
                                  selectedIndex: 0,
                                  selectedIndexD: selectedIndex!,
                                  pgnJns: pgnJns!,
                                ),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ).show();
                      }
                    }
                  },
                  child: const Text('SIMPAN'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CompBottomSrt extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  const CompBottomSrt({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomSrt> createState() => _CompBottomSrtState();
}

class _CompBottomSrtState extends State<CompBottomSrt> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
  String? pgnJns;

  Hibah? hibah;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();
  bool _isLoading = false;
  bool _isError = false;

  String? errorMessage;

  final TextEditingController inbPsn = TextEditingController();
  TextEditingController inbTgl = TextEditingController();
  TextEditingController inbJam = TextEditingController();

  String? inbSrt;

  final format = DateFormat("yyyy-MM-dd");
  final formatTime = DateFormat("HH:mm");

  APIResponseHibah<List<SrtForList>>? _apiResponseSrt;

  DateTime _date = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1947),
        lastDate: DateTime(2030));

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        inbTgl.text = format.format(_date);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
      builder: (context, childWidget) {
        final Widget mediaQueryWrapper = MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: childWidget!,
        );
        if (Localizations.localeOf(context).languageCode == 'in') {
          return Localizations.override(
            context: context,
            locale: const Locale('in', 'id'),
            child: mediaQueryWrapper,
          );
        }
        return mediaQueryWrapper;
      },
    );

    if (newTime == null) return;
    setState(() {
      inbJam.text = newTime.format(context);
    });
  }

  List? srt;

  @override
  void initState() {
    super.initState();
    _fetchSrt();
    setState(() {
      _isLoading = true;

      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
      pgnJns = widget.pgnJns;
    });
    if (uslIdEx != null) {
      service.getHibah(uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;

          if (hibah == null) {
            _isError = true;
          } else {
            _isError = false;
          }
          if (value.error) {
            _isLoading = false;
            errorMessage = value.errorMessage!;
          } else {
            _isLoading = false;
          }
          _isLoading = false;
        });
      });
    }
  }

  _fetchSrt() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponseSrt = await serviceComp.getSrtListPage();
    setState(() {
      if (_apiResponseSrt!.error) {
        _isLoading = false;
        errorMessage = _apiResponseSrt!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Kirim Surat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {},
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'certificate.png'),
                ),
                title: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.orgNm} - ${hibah!.uslNm}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.anggaran} - ${hibah!.uslHslAlt}',
                ),
              ),
              const Divider(
                height: 2,
              ),
              _apiResponseSrt == null
                  ? Container()
                  : _apiResponseSrt!.data == null
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFieldContainer(
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                prefixIcon: Icon(
                                  Icons.sync,
                                  size: 20,
                                ),
                              ),
                              items: _apiResponseSrt!.data!.map((item) {
                                return DropdownMenuItem(
                                  value: item.srtIdEx,
                                  child: Text(item.srtNm),
                                );
                              }).toList(),
                              hint: const Text(
                                "PILIH SALAH SATU JENIS SURAT",
                                style: TextStyle(fontSize: 15),
                              ),
                              value: inbSrt,
                              onChanged: (value) {
                                setState(() {
                                  inbSrt = value as String?;
                                });
                              },
                            ),
                          ),
                        ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextField(
                      maxLines: 3,
                      controller: inbPsn,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.comment_outlined,
                          size: 20,
                        ),
                        labelText: 'Pesan Tambahan',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      setState(() {
                        _selectDate(context);
                      });
                    },
                    controller: inbTgl,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.calendar_month_outlined,
                        size: 20,
                      ),
                      labelText: 'Pilih Tanggal',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      setState(() {
                        _selectTime(context);
                      });
                    },
                    controller: inbJam,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.access_time_rounded,
                        size: 20,
                      ),
                      labelText: 'Pilih Jam',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (ctx) => const FullScreenLoader(),
                          );
                          if (inbPsn.text == '' ||
                              inbSrt == null ||
                              inbTgl.text == '' ||
                              inbJam.text == '') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.TOPSLIDE,
                              title: 'Maaf',
                              desc: 'Lengkapi Data Terlebih Dahulu',
                              btnOkOnPress: () => Navigator.pop(context),
                            ).show();
                          } else {
                            final insertInb = InsertInb(
                              inbOrg: widget.orgIdEx,
                              inbUsl: widget.uslIdEx,
                              inbSrt: inbSrt!,
                              inbTgl: inbTgl.text,
                              inbJam: inbJam.text,
                              inbPsn: inbPsn.text,
                            );
                            final result = await service.insertInb(insertInb);
                            Navigator.pop(context);
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
                                  Navigator.pop(context);
                                },
                              ).show();
                            } else {
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
                                        uslIdEx: uslIdEx!,
                                        orgIdEx: orgIdEx!,
                                        token: token!,
                                        selectedIndex: 0,
                                        selectedIndexD: selectedIndex!,
                                        pgnJns: pgnJns!,
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ).show();
                            }
                          }
                        },
                        child: const Text('SIMPAN'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
  }
}

class CompBottomThp extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  final String uslThpNm;
  final String uslThpIdEx;
  final String uslThpTglMAlt;
  const CompBottomThp({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
    required this.uslThpNm,
    required this.uslThpIdEx,
    required this.uslThpTglMAlt,
  });

  @override
  State<CompBottomThp> createState() => _CompBottomThpState();
}

class _CompBottomThpState extends State<CompBottomThp> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
  String? pgnJns;

  Hibah? hibah;

  bool _isLoading = false;
  bool _isError = false;

  String? errorMessage;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  final TextEditingController uslThpKet = TextEditingController();
  TextEditingController uslThpTglA = TextEditingController();
  TextEditingController uslThpTglM = TextEditingController();
  TextEditingController uslThpNm = TextEditingController();

  final format = DateFormat("yyyy-MM-dd");

  DateTime _date = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1947),
        lastDate: DateTime(2030));

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        uslThpTglA.text = format.format(_date);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;

      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
      pgnJns = widget.pgnJns;
      uslThpNm.text = widget.uslThpNm;
      uslThpTglM.text = widget.uslThpTglMAlt;
    });
    if (uslIdEx != null) {
      service.getHibah(uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;

          if (hibah == null) {
            _isError = true;
          } else {
            _isError = false;
          }
          if (value.error) {
            _isLoading = false;
            errorMessage = value.errorMessage!;
          } else {
            _isLoading = false;
          }
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Perubahan Tahapan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {},
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'certificate.png'),
                ),
                title: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.orgNm} - ${hibah!.uslNm}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.anggaran} - ${hibah!.uslHslAlt}',
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: TextField(
                    readOnly: true,
                    controller: uslThpNm,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.calendar_month_outlined,
                        size: 20,
                      ),
                      labelText: 'Nama Tahapan',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: TextField(
                    readOnly: true,
                    controller: uslThpTglM,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.calendar_month_outlined,
                        size: 20,
                      ),
                      labelText: 'Tanggal Mulai',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      setState(() {
                        _selectDate(context);
                      });
                    },
                    controller: uslThpTglA,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.calendar_month_outlined,
                        size: 20,
                      ),
                      labelText: 'Tanggal Akhir',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextField(
                      maxLines: 3,
                      controller: uslThpKet,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.comment_outlined,
                          size: 20,
                        ),
                        labelText: 'Keterangan',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (ctx) => FullScreenLoader(),
                          );
                          if (uslThpKet.text == '' || uslThpTglA.text == '') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.TOPSLIDE,
                              title: 'Maaf',
                              desc: 'Lengkapi Data Terlebih Dahulu',
                              btnOkOnPress: () => Navigator.pop(context),
                            ).show();
                          } else {
                            final changeThp = ChangeThp(
                              uslThpUsl: uslIdEx!,
                              uslThpThp: widget.uslThpIdEx,
                              uslThpTglM: uslThpTglM.text,
                              uslThpTglA: uslThpTglA.text,
                              uslThpKet: uslThpKet.text,
                            );
                            final result = await service.changeThp(changeThp);
                            Navigator.pop(context);
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
                                  Navigator.pop(context);
                                },
                              ).show();
                            } else {
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
                                        uslIdEx: uslIdEx!,
                                        orgIdEx: orgIdEx!,
                                        token: token!,
                                        selectedIndex: 0,
                                        selectedIndexD: selectedIndex!,
                                        pgnJns: pgnJns!,
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ).show();
                            }
                          }
                        },
                        child: const Text('SIMPAN'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          );
  }
}

class CompBottomUslBa extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  const CompBottomUslBa({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomUslBa> createState() => _CompBottomUslBaState();
}

class _CompBottomUslBaState extends State<CompBottomUslBa> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;

  Hibah? hibah;

  bool _isLoading = false;
  bool _isError = false;

  String? errorMessage;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  final TextEditingController uslBaNm = TextEditingController();
  final TextEditingController uslBaFl = TextEditingController();

  File? _file;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;

      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
      uslBaFl.text = 'Tekan Disini Untuk Menambahkan Berkas';
    });
    if (uslIdEx != null) {
      service.getHibah(uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;

          if (hibah == null) {
            _isError = true;
          } else {
            _isError = false;
          }
          if (value.error) {
            _isLoading = false;
            errorMessage = value.errorMessage!;
          } else {
            _isLoading = false;
          }
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Berita Acara',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {},
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'certificate.png'),
                ),
                title: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.orgNm} - ${hibah!.uslNm}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.anggaran} - ${hibah!.uslHslAlt}',
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: TextField(
                    controller: uslBaNm,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.assignment_outlined,
                        size: 20,
                      ),
                      labelText: 'Nama Berkas',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: TextField(
                    readOnly: true,
                    onTap: () async {
                      final FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.any,
                      );
                      if (result == null) return;
                      setState(() {
                        _file = File(result.files.first.path.toString());
                        uslBaFl.text = result.files.first.path.toString();
                      });
                    },
                    controller: uslBaFl,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.attach_file,
                        size: 20,
                      ),
                      labelText: 'Berkas',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (ctx) => FullScreenLoader(),
                          );
                          if (uslBaNm.text == '' || _file == null) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.TOPSLIDE,
                              title: 'Maaf',
                              desc: 'Lengkapi Data Terlebih Dahulu',
                              btnOkOnPress: () => Navigator.pop(context),
                            ).show();
                          } else {
                            final result = await serviceComp.uslBaAdd(
                                widget.uslIdEx, uslBaNm.text, _file!.path);
                            Navigator.pop(context);
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
                                  Navigator.pop(context);
                                },
                              ).show();
                            } else {
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
                                        uslIdEx: uslIdEx!,
                                        orgIdEx: orgIdEx!,
                                        token: token!,
                                        selectedIndex: 0,
                                        selectedIndexD: 4,
                                        pgnJns: widget.pgnJns,
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ).show();
                            }
                          }
                        },
                        child: const Text('SIMPAN'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          );
  }
}

class CompBottomVerCtk extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  const CompBottomVerCtk({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomVerCtk> createState() => _CompBottomVerCtkState();
}

class _CompBottomVerCtkState extends State<CompBottomVerCtk> {
  String? errorMessage;

  bool _isLoading = false;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'CETAK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () async {
                  // Navigator.pop(context);
                  //verCtk1
                  String url =
                      'simhega.sultengprov.go.id/docVerM/verCtk1/${widget.uslIdEx}';
                  final result =
                      await serviceComp.getNumSrt('${widget.uslIdEx}/verCtk1');

                  if (result.error) {
                    showBottomModal(
                      context,
                      CompBottomNmrSrt(
                        uslIdEx: widget.uslIdEx,
                        orgIdEx: widget.orgIdEx,
                        selectedIndex: widget.selectedIndex,
                        token: widget.token,
                        pgnJns: widget.pgnJns,
                        srtNm: 'BAP Peninjauan Lapangan',
                        url: url,
                        docDoc: 'verCtk1',
                      ),
                      400,
                    );
                  } else {
                    Navigator.pop(context);

                    final Uri launcUri = Uri(scheme: 'http', path: url);
                    if (await canLaunchUrl(launcUri)) {
                      await launchUrl(
                        launcUri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      throw "Could not launch $url";
                    }
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'eye.png'),
                ),
                title: const Text(
                  'BAP Peninjauan Lapangan',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  //verCtk2
                  String url =
                      'simhega.sultengprov.go.id/docVerM/verCtk2/${widget.uslIdEx}';
                  final result =
                      await serviceComp.getNumSrt('${widget.uslIdEx}/verCtk2');
                  if (result.error) {
                    showBottomModal(
                      context,
                      CompBottomNmrSrt(
                        uslIdEx: widget.uslIdEx,
                        orgIdEx: widget.orgIdEx,
                        selectedIndex: widget.selectedIndex,
                        token: widget.token,
                        pgnJns: widget.pgnJns,
                        srtNm: 'Hasil Penelitian Kelengkapan Administrasi',
                        url: url,
                        docDoc: 'verCtk2',
                      ),
                      400,
                    );
                  } else {
                    Navigator.pop(context);

                    final Uri launcUri = Uri(scheme: 'http', path: url);
                    if (await canLaunchUrl(launcUri)) {
                      await launchUrl(
                        launcUri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      throw "Could not launch $url";
                    }
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'list.png'),
                ),
                title: const Text(
                  'Hasil Penelitian Kelengkapan Administrasi',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  //verCtk3
                  String url =
                      'simhega.sultengprov.go.id/docVerM/verCtk3/${widget.uslIdEx}';
                  final result =
                      await serviceComp.getNumSrt('${widget.uslIdEx}/verCtk3');
                  if (result == null) {
                    AwesomeDialog(
                      context: context,
                      title: 'Maaf',
                      dialogType: DialogType.ERROR,
                      desc: 'Tidak Dapat Menampilkan Nomor Surat',
                    ).show();
                  } else {
                    if (result.error) {
                      showBottomModal(
                        context,
                        CompBottomNmrSrt(
                          uslIdEx: widget.uslIdEx,
                          orgIdEx: widget.orgIdEx,
                          selectedIndex: widget.selectedIndex,
                          token: widget.token,
                          pgnJns: widget.pgnJns,
                          srtNm: 'Surat Pemberitahuan Hasil Evaluasi',
                          url: url,
                          docDoc: 'verCtk1',
                        ),
                        400,
                      );
                    } else {
                      Navigator.pop(context);
                      final Uri launcUri = Uri(scheme: 'http', path: url);
                      if (await canLaunchUrl(launcUri)) {
                        await launchUrl(
                          launcUri,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        throw "Could not launch $url";
                      }
                    }
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'evaluation.png'),
                ),
                title: const Text(
                  'Surat Pemberitahuan Hasil Evaluasi',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
            ],
          );
  }
}

class CompBottomCairCtkU extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  const CompBottomCairCtkU({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomCairCtkU> createState() => _CompBottomCairCtkUState();
}

class _CompBottomCairCtkUState extends State<CompBottomCairCtkU> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;

  String? errorMessage;

  bool _isLoading = false;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'CETAK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docCair/cairCtk2/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'invoice.png'),
                ),
                title: const Text(
                  'Kwitansi',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docCair/cairCtk4/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'sign.png'),
                ),
                title: const Text(
                  'Perjanjian Hibah Uang',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  //cairCtk5
                  String url =
                      'simhega.sultengprov.go.id/docCair/cairCtk5M/${widget.uslIdEx}';
                  final result =
                      await serviceComp.getNumSrt('${widget.uslIdEx}/cairCtk5');
                  if (result.error) {
                    showBottomModal(
                      context,
                      CompBottomNmrSrt(
                        uslIdEx: widget.uslIdEx,
                        orgIdEx: widget.orgIdEx,
                        selectedIndex: widget.selectedIndex,
                        token: widget.token,
                        pgnJns: widget.pgnJns,
                        srtNm:
                            'Surat Keterangan Kelengkapan Dokumen (Hibah Uang)',
                        url: url,
                        docDoc: 'verCtk1',
                      ),
                      400,
                    );
                  } else {
                    final Uri launcUri = Uri(scheme: 'http', path: url);
                    if (await canLaunchUrl(launcUri)) {
                      await launchUrl(
                        launcUri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      throw "Could not launch $url";
                    }
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'list.png'),
                ),
                title: const Text(
                  'Surat Keterangan Kelengkapan Dokumen (Hibah Uang)',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docCair/cairCtk7/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'file.png'),
                ),
                title: const Text(
                  'Surat Pernyataan Penerima Uang',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          );
  }
}

class CompBottomCairCtkB extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  const CompBottomCairCtkB({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomCairCtkB> createState() => _CompBottomCairCtkBState();
}

class _CompBottomCairCtkBState extends State<CompBottomCairCtkB> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;

  String? errorMessage;

  bool _isLoading = false;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'CETAK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docCair/cairCtk1/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'check.png'),
                ),
                title: const Text(
                  'Berita Acara Serah Terima Hibah Barang',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docCair/cairCtk3/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'sign.png'),
                ),
                title: const Text(
                  'Perjanjian Hibah Barang',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docCair/cairCtk6/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'boxes.png'),
                ),
                title: const Text(
                  'Surat Pernyataan Penerima Hibah Barang',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          );
  }
}

class CompBottomNmrSrt extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  final String srtNm;
  final String docDoc;
  final String url;
  const CompBottomNmrSrt({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
    required this.srtNm,
    required this.docDoc,
    required this.url,
  });

  @override
  State<CompBottomNmrSrt> createState() => _CompBottomNmrSrtState();
}

class _CompBottomNmrSrtState extends State<CompBottomNmrSrt> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
  String? pgnJns;
  String? srtNm;

  HibahService get service => GetIt.I<HibahService>();

  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  final TextEditingController usldocNmr = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
      pgnJns = widget.pgnJns;
      srtNm = widget.srtNm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            'Cetak Surat',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: () {},
          minLeadingWidth: 0,
          leading: const SizedBox(
            height: double.infinity,
            child: SPIcon(assetName: 'certificate.png'),
          ),
          title: const Text(
            'Nama Surat',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            srtNm == null ? 'Tidak Ada Nama Surat' : '$srtNm',
          ),
        ),
        const Divider(
          height: 2,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextFieldContainer(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                controller: usldocNmr,
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.format_list_numbered,
                    size: 20,
                  ),
                  labelText: 'Nomor Surat',
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (ctx) => const FullScreenLoader(),
                    );
                    if (usldocNmr.text == '') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.TOPSLIDE,
                        title: 'Maaf',
                        desc: 'Lengkapi Data Terlebih Dahulu',
                        btnOkOnPress: () => Navigator.pop(context),
                      ).show();
                    } else {
                      final insertDocUsl = InsertDocUsl(
                        uslDocUsl: widget.uslIdEx,
                        uslDocDoc: widget.docDoc,
                        uslDocNmr: usldocNmr.text,
                      );
                      final result = await service.insertDocUsl(insertDocUsl);
                      Navigator.pop(context);
                      final title = result.error ? 'Maaf' : 'Terima Kasih';
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
                            Navigator.pop(context);
                          },
                        ).show();
                      } else {
                        final Uri launcUri =
                            Uri(scheme: 'http', path: widget.url);
                        if (await canLaunchUrl(launcUri)) {
                          await launchUrl(
                            launcUri,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          throw "Could not launch ${widget.url}";
                        }
                      }
                    }
                  },
                  child: const Text('SIMPAN'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class TopHomeScreen extends StatefulWidget {
  final double height;
  final double width;
  final String title;
  const TopHomeScreen({
    super.key,
    required this.height,
    required this.width,
    required this.title,
  });

  @override
  State<TopHomeScreen> createState() => _TopHomeScreenState();
}

class _TopHomeScreenState extends State<TopHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: widget.height * 0.25,
          width: widget.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/def_head_1.png"),
                fit: BoxFit.cover),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue.withOpacity(1.0),
                Colors.blue.withOpacity(0.5),
                Colors.blue.withOpacity(0.1),
                Colors.blue.withOpacity(0.5),
                Colors.blue.withOpacity(1.0),
              ], begin: Alignment.topRight, end: Alignment.bottomLeft),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          left: 0.0,
          top: 50.0,
          child: Column(
            children: <Widget>[
              const Image(
                  image: AssetImage("assets/images/logo.png"), height: 50),
              RichText(
                text: const TextSpan(
                  text: 'SI-MHEGA',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 10.0,
                        offset: Offset.zero,
                      )
                    ],
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 10.0,
                        offset: Offset.zero,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.QUESTION,
                title: 'Maaf',
                desc: 'Apakah Ingin Keluar Dari Aplikasi',
                btnOkOnPress: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MasukScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                btnCancelOnPress: () {},
              ).show();
            },
            icon: const Icon(
              Icons.power_settings_new_rounded,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 10.0,
                  offset: Offset.zero,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CompBottomUslAStj extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  const CompBottomUslAStj({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomUslAStj> createState() => _CompBottomUslAStjState();
}

class _CompBottomUslAStjState extends State<CompBottomUslAStj> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
  String? pgnJns;

  Hibah? hibah;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();
  bool _isLoading = false;
  bool _isError = false;

  String? errorMessage;

  final TextEditingController usltAT = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;

      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
      pgnJns = widget.pgnJns;
    });
    if (uslIdEx != null) {
      service.getHibah(uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;

          if (hibah == null) {
            _isError = true;
          } else {
            _isError = false;
          }
          if (value.error) {
            _isLoading = false;
            errorMessage = value.errorMessage!;
          } else {
            _isLoading = false;
          }
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Ubah Jumlah Anggaran Yang Disetujui',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {},
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'certificate.png'),
                ),
                title: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.orgNm} - ${hibah!.uslNm}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.anggaran} - ${hibah!.uslHslAlt}',
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextField(
                      controller: usltAT,
                      decoration: const InputDecoration(
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.money,
                          size: 20,
                        ),
                        labelText: 'Total Anggaran',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (ctx) => const FullScreenLoader(),
                          );
                          if (usltAT.text == '') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.TOPSLIDE,
                              title: 'Maaf',
                              desc: 'Lengkapi Data Terlebih Dahulu',
                              btnOkOnPress: () => Navigator.pop(context),
                            ).show();
                          } else {
                            final insertUslAT = InsertUslAT(uslAt: usltAT.text);
                            final result = await service.insertUslAT(
                              insertUslAT,
                              widget.uslIdEx,
                            );
                            Navigator.pop(context);
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
                                  Navigator.pop(context);
                                },
                              ).show();
                            } else {
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
                                        uslIdEx: uslIdEx!,
                                        orgIdEx: orgIdEx!,
                                        token: token!,
                                        selectedIndex: selectedIndex!,
                                        selectedIndexD: 2,
                                        pgnJns: pgnJns!,
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ).show();
                            }
                          }
                        },
                        child: const Text('SIMPAN'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
  }
}

class CompBottomUslNPHD extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  const CompBottomUslNPHD({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomUslNPHD> createState() => _CompBottomUslNPHDState();
}

class _CompBottomUslNPHDState extends State<CompBottomUslNPHD> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
  String? pgnJns;

  Hibah? hibah;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();
  bool _isLoading = false;
  bool _isError = false;

  String? errorMessage;

  final TextEditingController uslNphd = TextEditingController();
  final TextEditingController uslNphdT = TextEditingController();

  final format = DateFormat("yyyy-MM-dd");

  DateTime _date = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1947),
        lastDate: DateTime(2030));

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        uslNphdT.text = format.format(_date);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;

      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
      pgnJns = widget.pgnJns;
    });
    if (uslIdEx != null) {
      service.getHibah(uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;

          if (hibah == null) {
            _isError = true;
          } else {
            _isError = false;
          }
          if (value.error) {
            _isLoading = false;
            errorMessage = value.errorMessage!;
          } else {
            _isLoading = false;
          }
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Nomor NPHD (Naskah Perjanjian Hibah Daerah)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {},
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'certificate.png'),
                ),
                title: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.orgNm} - ${hibah!.uslNm}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.anggaran} - ${hibah!.uslHslAlt}',
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextField(
                      controller: uslNphd,
                      decoration: const InputDecoration(
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.money,
                          size: 20,
                        ),
                        labelText: 'Nomor NPHD',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      setState(() {
                        _selectDate(context);
                      });
                    },
                    controller: uslNphdT,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.calendar_month_outlined,
                        size: 20,
                      ),
                      labelText: 'Tanggal NPHD',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (ctx) => const FullScreenLoader(),
                          );
                          if (uslNphd.text == '' || uslNphdT.text == '') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.TOPSLIDE,
                              title: 'Maaf',
                              desc: 'Lengkapi Data Terlebih Dahulu',
                              btnOkOnPress: () => Navigator.pop(context),
                            ).show();
                          } else {
                            final insertUslNHPD = InsertUslNHPD(
                              uslIdEx: widget.uslIdEx,
                              uslNphd: uslNphd.text,
                              uslNphdT: uslNphdT.text,
                            );
                            final result =
                                await service.insertUslNHPD(insertUslNHPD);
                            Navigator.pop(context);
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
                                  Navigator.pop(context);
                                },
                              ).show();
                            } else {
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
                                        uslIdEx: uslIdEx!,
                                        orgIdEx: orgIdEx!,
                                        token: token!,
                                        selectedIndex: selectedIndex!,
                                        selectedIndexD: 0,
                                        pgnJns: pgnJns!,
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ).show();
                            }
                          }
                        },
                        child: const Text('SIMPAN'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
  }
}

class CompBottomUslAP extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final int selectedIndexD;
  final String token;
  final String pgnJns;
  const CompBottomUslAP({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.selectedIndexD,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomUslAP> createState() => _CompBottomUslAPState();
}

class _CompBottomUslAPState extends State<CompBottomUslAP> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  int? selectedIndexD;
  String? token;
  String? pgnJns;

  Hibah? hibah;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  final TextEditingController _uslAPP = TextEditingController();

  bool _isLoading = false;
  bool _isError = false;

  String? errorMessage;

  String? _uslAPUslA;

  APIResponseHibah<List<UslA>>? _apiResponseUslA;

  List? uslA;

  @override
  void initState() {
    super.initState();
    _fetchUslA();

    setState(() {
      _isLoading = true;

      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      selectedIndexD = widget.selectedIndexD;
      token = widget.token;
      pgnJns = widget.pgnJns;
    });
    if (uslIdEx != null) {
      service.getHibah(uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;

          if (hibah == null) {
            _isError = true;
          } else {
            _isError = false;
          }
          if (value.error) {
            _isLoading = false;
            errorMessage = value.errorMessage!;
          } else {
            _isLoading = false;
          }
          _isLoading = false;
        });
      });
    }
  }

  _fetchUslA() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponseUslA = await service.getUslA(widget.uslIdEx);
    setState(() {
      if (_apiResponseUslA!.error) {
        _isLoading = false;
        errorMessage = _apiResponseUslA!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Tambah Berkas Pendukung Proposal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {},
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'certificate.png'),
                ),
                title: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.orgNm} - ${hibah!.uslNm}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.anggaran} - ${hibah!.uslHslAlt}',
                ),
              ),
              const Divider(
                height: 2,
              ),
              _apiResponseUslA == null
                  ? Container()
                  : _apiResponseUslA!.data == null
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFieldContainer(
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                prefixIcon: Icon(
                                  Icons.sync,
                                  size: 20,
                                ),
                              ),
                              items: _apiResponseUslA!.data!.map((item) {
                                return DropdownMenuItem(
                                  value: item.uslIdEx,
                                  child: Text(item.uslAU),
                                );
                              }).toList(),
                              hint: const Text(
                                "PILIH SALAH SATU PENGUSULAN ANGGARAN",
                                style: TextStyle(fontSize: 15),
                              ),
                              value: _uslAPUslA,
                              onChanged: (value) {
                                setState(() {
                                  _uslAPUslA = value as String?;
                                });
                              },
                            ),
                          ),
                        ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextField(
                      controller: _uslAPP,
                      decoration: const InputDecoration(
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.attach_money_rounded,
                          size: 20,
                        ),
                        hintText: 'Isikan Anggaran Yang Digunakan',
                        labelText: 'Penggunaan Anggaran',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (ctx) => const FullScreenLoader(),
                          );
                          if (_uslAPP.text == '' ||
                              _uslAPUslA == '' ||
                              _uslAPUslA == null) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.TOPSLIDE,
                              title: 'Maaf',
                              desc: 'Lengkapi Data Terlebih Dahulu',
                              btnOkOnPress: () => Navigator.pop(context),
                            ).show();
                          } else {
                            final insertUslAP = InsertUslAP(
                              uslAPUsla: _uslAPUslA!,
                              uslAPP: _uslAPP.text,
                            );
                            final result =
                                await service.insertUslAP(insertUslAP);
                            Navigator.pop(context);
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
                                  Navigator.pop(context);
                                },
                              ).show();
                            } else {
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
                                      builder: (context) => DetailScreenA(
                                        uslIdEx: uslIdEx!,
                                        orgIdEx: orgIdEx!,
                                        token: token!,
                                        selectedIndex: selectedIndex!,
                                        selectedIndexD: 7,
                                        pgnJns: pgnJns!,
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ).show();
                            }
                          }
                        },
                        child: const Text('SIMPAN'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
  }
}

class CompBottomUslNmr extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  const CompBottomUslNmr({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomUslNmr> createState() => _CompBottomUslNmrState();
}

class _CompBottomUslNmrState extends State<CompBottomUslNmr> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
  String? pgnJns;

  Hibah? hibah;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();
  bool _isLoading = false;
  bool _isError = false;

  String? errorMessage;

  final TextEditingController uslNmr = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;

      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
      pgnJns = widget.pgnJns;
    });
    if (uslIdEx != null) {
      service.getHibah(uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;

          if (hibah == null) {
            _isError = true;
          } else {
            _isError = false;
          }
          if (value.error) {
            _isLoading = false;
            errorMessage = value.errorMessage!;
          } else {
            _isLoading = false;
          }
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Tambah Nomor Surat Pengantar Proposal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {},
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'certificate.png'),
                ),
                title: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.orgNm} - ${hibah!.uslNm}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.anggaran} - ${hibah!.uslHslAlt}',
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextField(
                      controller: uslNmr,
                      decoration: const InputDecoration(
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.comment_outlined,
                          size: 20,
                        ),
                        labelText: 'Nomor Surat',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (ctx) => const FullScreenLoader(),
                          );
                          if (uslNmr.text == '') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.TOPSLIDE,
                              title: 'Maaf',
                              desc: 'Lengkapi Data Terlebih Dahulu',
                              btnOkOnPress: () => Navigator.pop(context),
                            ).show();
                          } else {
                            final insertUslNmr = InsertUslNmr(
                                uslIdEx: widget.uslIdEx, uslNmr: uslNmr.text);
                            final result =
                                await service.insertUslNmr(insertUslNmr);
                            Navigator.pop(context);
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
                                  Navigator.pop(context);
                                },
                              ).show();
                            } else {
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
                                        uslIdEx: uslIdEx!,
                                        orgIdEx: orgIdEx!,
                                        token: token!,
                                        selectedIndex: 0,
                                        selectedIndexD: selectedIndex!,
                                        pgnJns: pgnJns!,
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ).show();
                            }
                          }
                        },
                        child: const Text('SIMPAN'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
  }
}

class CompBottomNota extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final int selectedIndexD;
  final String token;
  final String pgnJns;
  const CompBottomNota({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.selectedIndexD,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomNota> createState() => _CompBottomNotaState();
}

class _CompBottomNotaState extends State<CompBottomNota> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  int? selectedIndexD;
  String? token;
  String? pgnJns;

  Hibah? hibah;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  final ImagePicker _picker = ImagePicker();

  final TextEditingController _uslNotaNm = TextEditingController();

  bool _isLoading = false;
  bool _isError = false;

  String? errorMessage;

  List? brks;

  File? _uslNotaBrks;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;

      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      selectedIndexD = widget.selectedIndexD;
      token = widget.token;
      pgnJns = widget.pgnJns;
    });
    if (uslIdEx != null) {
      service.getHibah(uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;

          if (hibah == null) {
            _isError = true;
          } else {
            _isError = false;
          }
          if (value.error) {
            _isLoading = false;
            errorMessage = value.errorMessage!;
          } else {
            _isLoading = false;
          }
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Tambah Berkas Nota Penggunaan Anggaran',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {},
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'certificate.png'),
                ),
                title: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.orgNm} - ${hibah!.uslNm}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.anggaran} - ${hibah!.uslHslAlt}',
                ),
              ),
              const Divider(
                height: 2,
              ),
              TextFieldContainer(
                child: TextField(
                  controller: _uslNotaNm,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.comment,
                      size: 20,
                    ),
                    hintText: 'Isikan Keterangan Nota Yang Diambil',
                    labelText: 'keterangan Nota',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 150,
                    height: 180,
                    padding: _uslNotaBrks == null
                        ? const EdgeInsets.all(10)
                        : const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(
                        width: 1,
                      ),
                      borderRadius: _uslNotaBrks == null
                          ? const BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            )
                          : const BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                    ),
                    child: Image(
                      width: 50,
                      height: 180,
                      image: _uslNotaBrks == null
                          ? const AssetImage(
                              'assets/images/image.png',
                            )
                          : FileImage(_uslNotaBrks!) as ImageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    width: 180,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 50,
                            maxHeight: 600,
                            maxWidth: 900,
                          );
                          if (image != null) {
                            setState(() {
                              _uslNotaBrks = File(image.path);
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
                                  Text('AMBIL GAMBAR'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _uslNotaBrks != null
                      ? SizedBox(
                          height: 0,
                          width: 0,
                          child: Image.file(_uslNotaBrks!),
                        )
                      : Container(),
                ]),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (ctx) => const FullScreenLoader(),
                          );
                          if (_uslNotaNm.text == '' || _uslNotaBrks == null) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.TOPSLIDE,
                              title: 'Maaf',
                              desc: 'Lengkapi Data Terlebih Dahulu',
                              btnOkOnPress: () => Navigator.pop(context),
                            ).show();
                          } else {
                            final result = await serviceComp.uslNotaAdd(
                                uslIdEx!, _uslNotaNm.text, _uslNotaBrks!.path);
                            Navigator.pop(context);
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
                                  Navigator.pop(context);
                                },
                              ).show();
                            } else {
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
                                      builder: (context) => DetailScreenA(
                                        uslIdEx: uslIdEx!,
                                        orgIdEx: orgIdEx!,
                                        token: token!,
                                        selectedIndex: 0,
                                        selectedIndexD: 7,
                                        pgnJns: pgnJns!,
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ).show();
                            }
                          }
                        },
                        child: const Text('SIMPAN'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
  }
}

class CompBottomLPJ extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final int selectedIndexD;
  final String token;
  final String pgnJns;
  const CompBottomLPJ({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.selectedIndexD,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomLPJ> createState() => _CompBottomLPJState();
}

class _CompBottomLPJState extends State<CompBottomLPJ> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  int? selectedIndexD;
  String? token;
  String? pgnJns;

  Hibah? hibah;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  final ImagePicker _picker = ImagePicker();

  final TextEditingController _uslLPJBrksNm = TextEditingController();
  String? _uslLPJNm;

  bool _isLoading = false;
  bool _isError = false;

  String? errorMessage;

  List? brks;

  File? _uslLPJBrks;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;

      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      selectedIndexD = widget.selectedIndexD;
      token = widget.token;
      pgnJns = widget.pgnJns;
    });
    if (uslIdEx != null) {
      service.getHibah(uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;

          if (hibah == null) {
            _isError = true;
          } else {
            _isError = false;
          }
          if (value.error) {
            _isLoading = false;
            errorMessage = value.errorMessage!;
          } else {
            _isLoading = false;
          }
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Tambah Berkas LPJ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {},
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'certificate.png'),
                ),
                title: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.orgNm} - ${hibah!.uslNm}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.anggaran} - ${hibah!.uslHslAlt}',
                ),
              ),
              const Divider(
                height: 2,
              ),
              TextFieldContainer(
                child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Icon(
                      Icons.sync,
                      size: 20,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Laporan Pertanggung Jawaban',
                      child: Text('Laporan Pertanggung Jawaban'),
                    ),
                    DropdownMenuItem(
                      value: 'Surat Laporan Pertanggung Jawaban',
                      child: Text('Surat Laporan Pertanggung Jawaban'),
                    ),
                  ],
                  hint: const Text(
                    "PILIH SALAH SATU JENIS BERKAS",
                    style: TextStyle(fontSize: 15),
                  ),
                  value: _uslLPJNm,
                  onChanged: (value) {
                    setState(() {
                      _uslLPJNm = value as String?;
                    });
                  },
                ),
              ),
              const Divider(
                height: 2,
              ),
              TextFieldContainer(
                child: TextField(
                  controller: _uslLPJBrksNm,
                  readOnly: true,
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'doc']);
                    if (result != null) {
                      setState(() {
                        _uslLPJBrks = File(result.files.single.path!);
                        _uslLPJBrksNm.text = result.files.single.path!;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.credit_card,
                      size: 20,
                    ),
                    hintText: 'Isikan Keterangan Gambar Yang Diambil',
                    labelText: 'Berkas Pendukung',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (ctx) => const FullScreenLoader(),
                          );
                          if (_uslLPJNm == '' ||
                              _uslLPJNm == null ||
                              _uslLPJBrksNm.text == '') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.TOPSLIDE,
                              title: 'Maaf',
                              desc: 'Lengkapi Data Terlebih Dahulu',
                              btnOkOnPress: () => Navigator.pop(context),
                            ).show();
                          } else {
                            final result = await serviceComp.uslLPJAdd(
                                uslIdEx!, _uslLPJNm!, _uslLPJBrks!.path);
                            Navigator.pop(context);
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
                                  Navigator.pop(context);
                                },
                              ).show();
                            } else {
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
                                      builder: (context) => DetailScreenA(
                                        uslIdEx: uslIdEx!,
                                        orgIdEx: orgIdEx!,
                                        token: token!,
                                        selectedIndex: 0,
                                        selectedIndexD: 7,
                                        pgnJns: pgnJns!,
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ).show();
                            }
                          }
                        },
                        child: const Text('SIMPAN'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
  }
}

class CompBottomOrgCtk extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  const CompBottomOrgCtk({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomOrgCtk> createState() => _CompBottomOrgCtkState();
}

class _CompBottomOrgCtkState extends State<CompBottomOrgCtk> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;

  String? errorMessage;

  bool _isLoading = false;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'CETAK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docOrg/orgCtk1/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'pact.png'),
                ),
                title: const Text(
                  'Pakta Integritas',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docOrg/orgCtk2/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'rating.png'),
                ),
                title: const Text(
                  'Profil',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docOrg/orgCtk3/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'email.png'),
                ),
                title: const Text(
                  'Surat Pengusulan',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  String url =
                      'simhega.sultengprov.go.id/docOrg/orgCtk41/${widget.uslIdEx}';
                  Navigator.pop(context);
                  showBottomModal(
                    context,
                    CompBottomNmrSrtWURL(
                      uslIdEx: widget.uslIdEx,
                      orgIdEx: widget.orgIdEx,
                      selectedIndex: widget.selectedIndex,
                      token: widget.token,
                      pgnJns: widget.pgnJns,
                      srtNm: 'Surat Permohonan Penandatanganan',
                      url: url,
                      docDoc: 'verCtk2',
                    ),
                    400,
                  );
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'sign.png'),
                ),
                title: const Text(
                  'Surat Permohonan Penandatanganan',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docOrg/orgCtk5/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'preview.png'),
                ),
                title: const Text(
                  'Surat Pernyataan Siap Diaudit',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docOrg/orgCtk6/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'deal.png'),
                ),
                title: const Text(
                  'Surat Pernyataan Tanggung Jawab',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docOrg/orgCtk7/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'deal.png'),
                ),
                title: const Text(
                  'Surat Pernyataan Tanggung Jawab 2',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
            ],
          );
  }
}

class CompBottomNmrSrtWURL extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  final String srtNm;
  final String docDoc;
  final String url;
  const CompBottomNmrSrtWURL({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
    required this.srtNm,
    required this.docDoc,
    required this.url,
  });

  @override
  State<CompBottomNmrSrtWURL> createState() => _CompBottomNmrSrtWURLState();
}

class _CompBottomNmrSrtWURLState extends State<CompBottomNmrSrtWURL> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
  String? pgnJns;
  String? srtNm;

  HibahService get service => GetIt.I<HibahService>();

  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  final TextEditingController usldocNmr = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
      pgnJns = widget.pgnJns;
      srtNm = widget.srtNm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            'Cetak Surat',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: () {},
          minLeadingWidth: 0,
          leading: const SizedBox(
            height: double.infinity,
            child: SPIcon(assetName: 'certificate.png'),
          ),
          title: const Text(
            'Nama Surat',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            srtNm == null ? 'Tidak Ada Nama Surat' : '$srtNm',
          ),
        ),
        const Divider(
          height: 2,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextFieldContainer(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                controller: usldocNmr,
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.format_list_numbered,
                    size: 20,
                  ),
                  labelText: 'Nomor Surat',
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (ctx) => const FullScreenLoader(),
                    );
                    if (usldocNmr.text == '') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.TOPSLIDE,
                        title: 'Maaf',
                        desc: 'Lengkapi Data Terlebih Dahulu',
                        btnOkOnPress: () => Navigator.pop(context),
                      ).show();
                    } else {
                      Navigator.pop(context);
                      final Uri launcUri = Uri(
                          scheme: 'http',
                          path: widget.url,
                          query: 'nmr=${usldocNmr.text}');
                      if (await canLaunchUrl(launcUri)) {
                        await launchUrl(
                          launcUri,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        throw "Could not launch ${widget.url}";
                      }
                    }
                  },
                  child: const Text('SIMPAN'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CompBottomCairCtk extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  const CompBottomCairCtk({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<CompBottomCairCtk> createState() => _CompBottomCairCtkState();
}

class _CompBottomCairCtkState extends State<CompBottomCairCtk> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;

  String? errorMessage;

  bool _isLoading = false;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'CETAK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docCair/cairCtk2/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'invoice.png'),
                ),
                title: const Text(
                  'Kwitansi',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docCair/cairCtk4/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'sign.png'),
                ),
                title: const Text(
                  'Perjanjian Hibah Uang',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  //cairCtk5
                  String url =
                      'simhega.sultengprov.go.id/docCair/cairCtk5M/${widget.uslIdEx}';
                  final result =
                      await serviceComp.getNumSrt('${widget.uslIdEx}/cairCtk5');
                  if (result.error) {
                    showBottomModal(
                      context,
                      CompBottomNmrSrt(
                        uslIdEx: widget.uslIdEx,
                        orgIdEx: widget.orgIdEx,
                        selectedIndex: widget.selectedIndex,
                        token: widget.token,
                        pgnJns: widget.pgnJns,
                        srtNm:
                            'Surat Keterangan Kelengkapan Dokumen (Hibah Uang)',
                        url: url,
                        docDoc: 'verCtk1',
                      ),
                      400,
                    );
                  } else {
                    final Uri launcUri = Uri(scheme: 'http', path: url);
                    if (await canLaunchUrl(launcUri)) {
                      await launchUrl(
                        launcUri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      throw "Could not launch $url";
                    }
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'list.png'),
                ),
                title: const Text(
                  'Surat Keterangan Kelengkapan Dokumen (Hibah Uang)',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  final String url =
                      'simhega.sultengprov.go.id/docCair/cairCtk7/${widget.uslIdEx}';
                  final Uri launcUri = Uri(scheme: 'http', path: url);
                  if (await canLaunchUrl(launcUri)) {
                    await launchUrl(
                      launcUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw "Could not launch $url";
                  }
                },
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'file.png'),
                ),
                title: const Text(
                  'Surat Pernyataan Penerima Uang',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          );
  }
}

class CompBottomTolak extends StatefulWidget {
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final String token;
  final String pgnJns;
  final String inbJdlBrt;
  final String uslSlsBrt;
  final String uslHslBrt;
  final String inbOrgBrt;
  final String inbUslBrt;
  final String inbSrtBrt;
  const CompBottomTolak({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
    required this.pgnJns,
    required this.inbJdlBrt,
    required this.uslSlsBrt,
    required this.uslHslBrt,
    required this.inbOrgBrt,
    required this.inbUslBrt,
    required this.inbSrtBrt,
  });

  @override
  State<CompBottomTolak> createState() => _CompBottomTolakState();
}

class _CompBottomTolakState extends State<CompBottomTolak> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
  String? pgnJns;

  Hibah? hibah;

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();
  bool _isLoading = false;
  bool _isError = false;

  String? errorMessage;

  TextEditingController inbPsn = TextEditingController();
  TextEditingController inbJdl = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;

      uslIdEx = widget.uslIdEx;
      orgIdEx = widget.orgIdEx;
      selectedIndex = widget.selectedIndex;
      token = widget.token;
      inbJdl.text = widget.inbJdlBrt;
      pgnJns = widget.pgnJns;
    });
    if (uslIdEx != null) {
      service.getHibah(uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;

          if (hibah == null) {
            _isError = true;
          } else {
            _isError = false;
          }
          if (value.error) {
            _isLoading = false;
            errorMessage = value.errorMessage!;
          } else {
            _isLoading = false;
          }
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Kirim Surat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {},
                minLeadingWidth: 0,
                leading: const SizedBox(
                  height: double.infinity,
                  child: SPIcon(assetName: 'certificate.png'),
                ),
                title: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.orgNm} - ${hibah!.uslNm}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  hibah == null
                      ? 'Tidak Ada Data Proposal'
                      : '${hibah!.anggaran} - ${hibah!.uslHslAlt}',
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextField(
                      controller: inbJdl,
                      decoration: const InputDecoration(
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.comment_outlined,
                          size: 20,
                        ),
                        labelText: 'Judul Pesan',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFieldContainer(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextField(
                      maxLines: 3,
                      controller: inbPsn,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.comment_outlined,
                          size: 20,
                        ),
                        labelText: 'Pesan Tambahan',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (ctx) => const FullScreenLoader(),
                          );
                          if (inbPsn.text == '' || inbJdl.text == '') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.TOPSLIDE,
                              title: 'Maaf',
                              desc: 'Lengkapi Data Terlebih Dahulu',
                              btnOkOnPress: () => Navigator.pop(context),
                            ).show();
                          } else {
                            final addBrt = AddBrt(
                              inbOrg: widget.orgIdEx,
                              inbUsl: widget.uslIdEx,
                              inbSrt: widget.inbSrtBrt,
                              inbJdl: inbJdl.text,
                              inbPsn: inbPsn.text,
                              uslSls: widget.uslSlsBrt,
                              uslHsl: widget.uslHslBrt,
                            );
                            final result = await service.addBrt(addBrt);
                            Navigator.pop(context);
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
                                  Navigator.pop(context);
                                },
                              ).show();
                            } else {
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
                                        uslIdEx: uslIdEx!,
                                        orgIdEx: orgIdEx!,
                                        token: token!,
                                        selectedIndex: 0,
                                        selectedIndexD: selectedIndex!,
                                        pgnJns: pgnJns!,
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ).show();
                            }
                          }
                        },
                        child: const Text('SIMPAN'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
  }
}
