import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/models/hibahpost_model.dart';
import 'package:SimhegaM/screens/detail_screen.dart';
import 'package:SimhegaM/screens/items/func_item.dart';
import 'package:SimhegaM/screens/items/sp_icon.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      builder: (ctx) => _FullScreenLoader(),
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

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
        child: const Center(child: CircularProgressIndicator()));
  }
}
