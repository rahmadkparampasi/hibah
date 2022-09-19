// ignore_for_file: unnecessary_const

import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/detail_screen.dart';
import 'package:SimhegaM/screens/items/sp_icon.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:SimhegaM/services/hibahstj_services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:SimhegaM/screens/items/comp_items.dart';

class UslConfList extends StatefulWidget {
  String uslIdEx;
  String token;
  int selectedIndexD;

  UslConfList({
    super.key,
    required this.uslIdEx,
    required this.token,
    required this.selectedIndexD,
  });

  @override
  State<UslConfList> createState() => _UslConfListState();
}

class _UslConfListState extends State<UslConfList> {
  String? uslIdEx;
  HibahService get service => GetIt.I<HibahService>();
  HibahStjService get serviceStj => GetIt.I<HibahStjService>();
  bool _isError = false;
  bool _isLoading = false;
  String? errorMessage;
  APIResponseHibah<List<UslVer>>? uslVer;

  Hibah? hibah;

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      _isLoading = true;
    });
    if (uslIdEx != null) {
      service.getHibah(uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return hibah == null
        ? Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  child: const ListTile(
                    leading: SizedBox(
                      height: double.infinity,
                      child: SPIcon(assetName: 'ban.png'),
                    ),
                    minLeadingWidth: 0,
                    title: Text(
                      'Jenis Verifikasi',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    subtitle: Text('Belum Dapat Memverifikasi'),
                  ),
                )
              ],
            ),
          )
        : hibah!.uslSls == "1"
            ? Container(
                child: DismissibleWidget(
                  item: hibah,
                  onDismissed: (direction) async {
                    showDialog(
                      context: context,
                      builder: (ctx) => const FullScreenLoader(),
                    );
                    dismissItem(context, direction, 'Verifikasi Berkas Fisik',
                        () async {
                      final url = 'verFisik/$uslIdEx';
                      final result = await serviceStj.changeStj(url);
                      final title = result.error ? 'Maaf' : 'Terima Kasih';
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
                                uslIdEx: widget.uslIdEx,
                                orgIdEx: hibah!.uslOrg,
                                token: widget.token,
                                selectedIndexD: widget.selectedIndexD,
                              ),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                      ).show();
                    }, () {
                      Navigator.pop(context);
                    });
                  },
                  child: const Card(
                    elevation: 3,
                    child: const ListTile(
                      leading: SizedBox(
                        height: double.infinity,
                        child: SPIcon(assetName: 'check.png'),
                      ),
                      title: const Text(
                        'Jenis Verifikasi',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      subtitle: Text(
                        'Verifikasi Berkas Fisik',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : hibah!.uslSls == "2"
                ? Container(
                    child: DismissibleWidget(
                      item: hibah,
                      onDismissed: (direction) async {
                        showDialog(
                          context: context,
                          builder: (ctx) => const FullScreenLoader(),
                        );
                        dismissItem(context, direction, 'Verifikasi Lapangan',
                            () async {
                          final url = 'verLap/$uslIdEx';
                          final result = await serviceStj.changeStj(url);
                          final title = result.error ? 'Maaf' : 'Terima Kasih';
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
                                    uslIdEx: widget.uslIdEx,
                                    orgIdEx: hibah!.uslOrg,
                                    token: widget.token,
                                    selectedIndexD: widget.selectedIndexD,
                                  ),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            },
                          ).show();
                        }, () {
                          Navigator.pop(context);
                        });
                      },
                      child: const Card(
                        elevation: 3,
                        child: const ListTile(
                          leading: SizedBox(
                            height: double.infinity,
                            child: SPIcon(assetName: 'check.png'),
                          ),
                          title: const Text(
                            'Jenis Verifikasi',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          subtitle: Text(
                            'Verifikasi Lapangan',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container();
  }

  void dismissItem(BuildContext context, DismissDirection direction,
      String desc, dynamic Function()? ok, dynamic Function()? cancel) {
    switch (direction) {
      case DismissDirection.endToStart:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.QUESTION,
          title: 'Menolak',
          desc: desc,
          btnOkOnPress: ok,
          btnCancelOnPress: cancel,
        ).show();
        break;
      case DismissDirection.startToEnd:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.QUESTION,
          title: 'Menyetujui',
          desc: desc,
          btnOkOnPress: ok,
          btnCancelOnPress: cancel,
        ).show();
        break;
      default:
        break;
    }
  }
}

class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final ConfirmDismissCallback onDismissed;

  const DismissibleWidget({
    required this.item,
    required this.child,
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: ObjectKey(item),
        background: buildSwipeActionLeft(),
        secondaryBackground: buildSwipeActionRight(),
        confirmDismiss: onDismissed,
        child: child,
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.green,
        child: const Icon(Icons.archive_sharp, color: Colors.white, size: 32),
      );

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete_forever, color: Colors.white, size: 32),
      );
}
