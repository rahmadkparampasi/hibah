import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/detaila_screen.dart';
import 'package:SimhegaM/screens/items/comp_items.dart';
import 'package:SimhegaM/screens/items/func_item.dart';
import 'package:SimhegaM/screens/items/preimg_items.dart';
import 'package:SimhegaM/screens/items/prepdf_items.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:SimhegaM/services/hibahcomp_services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class UslAPList extends StatefulWidget {
  final String uslIdEx;
  final String uslSls;
  final String orgIdEx;
  final String token;
  final String pgnJns;
  final int selectedIndex;
  final int selectedIndexD;
  const UslAPList({
    super.key,
    required this.uslIdEx,
    required this.uslSls,
    required this.orgIdEx,
    required this.selectedIndex,
    required this.selectedIndexD,
    required this.token,
    required this.pgnJns,
  });

  @override
  State<UslAPList> createState() => _UslAPListState();
}

class _UslAPListState extends State<UslAPList> {
  String? uslIdEx;
  String _uslSls = "0";

  int? sortColumnIndex;
  bool isAscending = false;
  bool _isLoading = false;
  bool _isError = false;
  bool _isErrorStj = false;
  bool _isErrorAng = false;

  final columnsAP = [
    'No',
    'Kebutuhan',
    'Penerimaan',
    'Pengeluaran',
    'Saldo',
  ];

  final columnsNota = ['No', 'Nama Berkas', 'Berkas'];
  final columnsNotaAct = ['No', 'Nama Berkas', 'Berkas', 'Aksi'];

  final columnsLPJ = ['No', 'Nama Berkas', 'Berkas'];
  final columnsLPJAct = ['No', 'Nama Berkas', 'Berkas', 'Aksi'];

  String? errorMessage;
  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  APIResponseHibah<List<UslAP>>? uslAP;

  Saldo? saldo;

  APIResponseHibah<List<UslNota>>? uslNota;

  APIResponseHibah<List<UslLPJ>>? uslLpj;

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      _uslSls = widget.uslSls;

      _isError = true;
      _isErrorStj = true;
      _isErrorAng = true;
    });
    _fetchUslA(uslIdEx!);
    _fetchUslNota(uslIdEx!);
    _fetchUslLPJ(uslIdEx!);

    if (uslIdEx != null) {
      service.getSaldo(uslIdEx!).then((value) {
        setState(() {
          saldo = value.data;
        });
      });
    }
  }

  _fetchUslA(String uslIdEx) async {
    uslAP = await service.getUslAP(uslIdEx);
    setState(() {
      if (uslAP!.data!.isEmpty) {
        _isError = true;
      } else {
        _isError = false;
      }
      if (uslAP!.error) {
        _isLoading = false;
        errorMessage = uslAP!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  _fetchUslNota(String uslIdEx) async {
    uslNota = await service.getUslNota(uslIdEx);
    setState(() {
      if (uslNota!.data!.isEmpty) {
        _isError = true;
      } else {
        _isError = false;
      }
      if (uslNota!.error) {
        _isLoading = false;
        errorMessage = uslNota!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  _fetchUslLPJ(String uslIdEx) async {
    uslLpj = await service.getUslLPJ(uslIdEx);
    setState(() {
      if (uslLpj!.data!.isEmpty) {
        _isError = true;
      } else {
        _isError = false;
      }
      if (uslLpj!.error) {
        _isLoading = false;
        errorMessage = uslLpj!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Container(
          child: const Center(
            child: Text(
              'Penggunaan Anggaran',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 17),
            ),
          ),
        ),
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _uslSls == "6" || _uslSls == "7"
                //Tambah Penggunaan Anggaran

                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                              const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          onPressed: () => showBottomModal(
                              context,
                              CompBottomUslAP(
                                uslIdEx: uslIdEx!,
                                orgIdEx: widget.orgIdEx,
                                selectedIndex: widget.selectedIndex,
                                token: widget.token,
                                pgnJns: widget.pgnJns,
                                selectedIndexD: 2,
                              ),
                              550),
                          child: Container(
                            height: 35,
                            child: const Center(
                              child: Text('TAMBAH'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
        _isError
            ? Column(
                children: const <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Belum Ada Penggunaan Anggaran',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                children: <Widget>[
                  uslAP == null
                      ? const Center(
                          child: Text('Belum Ada Penggunaan Anggaran'),
                        )
                      : Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                DataTable(
                                    columns: getColumns(columnsAP),
                                    rows: getRows(
                                      uslAP,
                                    ))
                              ],
                            ),
                          ),
                        )
                ],
              ),
        const SizedBox(
          height: 5,
        ),
        Column(
          children: <Widget>[
            Container(
              child: Center(
                  child: saldo == null
                      ? const Text(
                          'Total Sisa Saldo : Belum Ada Penggunaan Anggaran')
                      : Text(
                          'Total Sisa Saldo : ${saldo!.saldoB}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            Container(
              child: const Center(
                child: Text(
                  'Nota Penggunaan Anggaran',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 17),
                ),
              ),
            ),
            _uslSls == "6" || _uslSls == "7"
                //Tambah Nota Penggunaan Anggaran

                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                              const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          onPressed: () => showBottomModal(
                              context,
                              CompBottomNota(
                                uslIdEx: uslIdEx!,
                                orgIdEx: widget.orgIdEx,
                                selectedIndex: widget.selectedIndex,
                                token: widget.token,
                                pgnJns: widget.pgnJns,
                                selectedIndexD: 2,
                              ),
                              550),
                          child: Container(
                            height: 35,
                            child: const Center(
                              child: Text('TAMBAH'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                uslNota == null
                    ? Column(
                        children: const <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Belum Ada Nota Penggunaan Anggaran',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          Divider(),
                        ],
                      )
                    : Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: _uslSls == "6" || _uslSls == "7"
                                ? getColumns(columnsNotaAct)
                                : getColumns(columnsNota),
                            rows: getRowsNota(uslNota),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      String url =
                          'simhega.sultengprov.go.id/docCair/rekap/${widget.uslIdEx}';
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
                    child: Container(
                      height: 45,
                      child: Center(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.print_outlined),
                            SizedBox(
                              width: 2,
                            ),
                            Text('Rekapitulasi Penggunaan Anggaran'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: const Center(
                        child: Text(
                          'Berkas LPJ',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54, fontSize: 17),
                        ),
                      ),
                    ),
                    _uslSls == "6" || _uslSls == "7"
                        ? Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  style: ButtonStyle(
                                    textStyle: MaterialStateProperty.all(
                                      const TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  onPressed: () => showBottomModal(
                                      context,
                                      CompBottomLPJ(
                                        uslIdEx: uslIdEx!,
                                        orgIdEx: widget.orgIdEx,
                                        selectedIndex: widget.selectedIndex,
                                        token: widget.token,
                                        pgnJns: widget.pgnJns,
                                        selectedIndexD: 2,
                                      ),
                                      550),
                                  child: Container(
                                    height: 35,
                                    child: const Center(
                                      child: Text('TAMBAH'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        uslLpj == null
                            ? Column(
                                children: const <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Belum Ada LPJ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Divider(),
                                ],
                              )
                            : Container(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: _uslSls == "6" || _uslSls == "7"
                                        ? getColumns(columnsLPJAct)
                                        : getColumns(columnsLPJ),
                                    rows: getRowsLPJ(uslLpj),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(label: Text(column)),
      )
      .toList();

  List<DataRow> getRows(APIResponseHibah<List<UslAP>>? uslAP) =>
      uslAP!.data!.map((UslAP usl) {
        final cells = [
          usl.uslAPno == 0 ? const Text('') : Text('${usl.uslAPno}'),
          Text(usl.uslAPU),
          Text(usl.uslAPP),
          Text(usl.uslAPK),
          Text(usl.uslAPS),
        ];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(data)).toList();

  List<DataRow> getRowsNota(APIResponseHibah<List<UslNota>>? uslNota) =>
      _uslSls == "6" || _uslSls == "7"
          ? uslNota!.data!.map((UslNota usl) {
              final cells = [
                Text('${usl.no}'),
                Text(usl.uslNotaNm),
                Container(
                  width: 40,
                  child: ButtonDTP(
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreImg(
                              name: 'Foto ${usl.uslNotaNm}',
                              img: usl.uslNotaFl,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ButtonDTP(
                  child: IconButton(
                    iconSize: 20,
                    onPressed: () async {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.QUESTION,
                              title: 'Menyetujui',
                              desc: 'Menghapus Data Nota',
                              btnOkOnPress: () async {
                                final result = await serviceComp
                                    .uslNotaDelete(usl.uslNotaIdex);
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
                                        builder: (context) => DetailScreenA(
                                          uslIdEx: widget.uslIdEx,
                                          orgIdEx: widget.orgIdEx,
                                          token: widget.token,
                                          selectedIndexD: 7,
                                          pgnJns: widget.pgnJns,
                                        ),
                                      ),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                ).show();
                              },
                              btnCancelOnPress: () {})
                          .show();
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ];
              return DataRow(cells: getCellsNota(cells));
            }).toList()
          : uslNota!.data!.map((UslNota usl) {
              final cells = [
                Text('${usl.no}'),
                Text(usl.uslNotaNm),
                Container(
                  width: 40,
                  child: ButtonDTP(
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreImg(
                              name: 'Foto ${usl.uslNotaNm}',
                              img: usl.uslNotaFl,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ];
              return DataRow(cells: getCellsNota(cells));
            }).toList();

  List<DataCell> getCellsNota(List<dynamic> cells) =>
      cells.map((data) => DataCell(data)).toList();

  List<DataRow> getRowsLPJ(APIResponseHibah<List<UslLPJ>>? uslLpj) =>
      _uslSls == "6" || _uslSls == "7"
          ? uslLpj!.data!.map((UslLPJ usl) {
              final cells = [
                Text('${usl.no}'),
                Text(usl.uslLpjNm),
                Container(
                  width: 40,
                  child: ButtonDTP(
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrePdf(
                              name: 'Berkas ${usl.uslLpjNm}',
                              pdf: usl.uslLpjFl,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.picture_as_pdf_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ButtonDTP(
                  child: IconButton(
                    iconSize: 20,
                    onPressed: () async {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.QUESTION,
                              title: 'Menyetujui',
                              desc: 'Menghapus Data LPJ',
                              btnOkOnPress: () async {
                                final result = await serviceComp
                                    .uslLPJDelete(usl.uslLpjIdex);
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
                                        builder: (context) => DetailScreenA(
                                          uslIdEx: widget.uslIdEx,
                                          orgIdEx: widget.orgIdEx,
                                          token: widget.token,
                                          selectedIndexD: 7,
                                          pgnJns: widget.pgnJns,
                                        ),
                                      ),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                ).show();
                              },
                              btnCancelOnPress: () {})
                          .show();
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ];
              return DataRow(cells: getCellsNota(cells));
            }).toList()
          : uslLpj!.data!.map((UslLPJ usl) {
              final cells = [
                Text('${usl.no}'),
                Text(usl.uslLpjNm),
                Container(
                  width: 40,
                  child: ButtonDTP(
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreImg(
                              name: 'Berkas ${usl.uslLpjNm}',
                              img: usl.uslLpjFl,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.picture_as_pdf_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ];
              return DataRow(cells: getCellsNota(cells));
            }).toList();

  List<DataCell> getCellsLPJ(List<dynamic> cells) =>
      cells.map((data) => DataCell(data)).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      uslAP!.data!.sort((user1, user2) => compareString(
          ascending, user1.uslAPno.toString(), user2.uslAPno.toString()));
    } else if (columnIndex == 1) {
      uslAP!.data!.sort((user1, user2) =>
          compareString(ascending, user1.uslAPU, user2.uslAPU));
    }

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
