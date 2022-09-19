import 'dart:io';
import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/models/hibahpost_model.dart';
import 'package:SimhegaM/screens/detail_screen.dart';
import 'package:SimhegaM/screens/items/func_item.dart';
import 'package:SimhegaM/screens/items/sp_icon.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:SimhegaM/services/hibahcomp_services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
  const CompBottomUslT({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
  });

  @override
  State<CompBottomUslT> createState() => _CompBottomUslTState();
}

class _CompBottomUslTState extends State<CompBottomUslT> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
  @override
  void initState() {
    // TODO: implement initState
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
  const CompBottomUslTThn({
    super.key,
    required this.uslT,
    required this.icon,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
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
  const CompBottomUslVer({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
  });

  @override
  State<CompBottomUslVer> createState() => _CompBottomUslVerState();
}

class _CompBottomUslVerState extends State<CompBottomUslVer> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;
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
                                  pgwNip: _apiResponsePgw!.data![index].pgwNip),
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
  final String pgwJbt;
  final String pgwNip;
  final String pgwGol;
  const CompBottomUslVerP({
    super.key,
    required this.uslVerUsl,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
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
  const CompBottomSrt({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
  });

  @override
  State<CompBottomSrt> createState() => _CompBottomSrtState();
}

class _CompBottomSrtState extends State<CompBottomSrt> {
  String? uslIdEx;
  String? orgIdEx;
  int? selectedIndex;
  String? token;

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
                            builder: (ctx) => FullScreenLoader(),
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
  final String uslThpNm;
  final String uslThpIdEx;
  final String uslThpTglMAlt;
  const CompBottomThp({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
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
  const CompBottomUslBa({
    super.key,
    required this.uslIdEx,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.token,
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
                        uslBaNm.text = result.files.first.path.toString();
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
