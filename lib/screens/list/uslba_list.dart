import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/detail_screen.dart';
import 'package:SimhegaM/screens/items/comp_items.dart';
import 'package:SimhegaM/screens/items/prepdf_items.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:SimhegaM/services/hibahcomp_services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UslBaList extends StatefulWidget {
  final String uslIdEx;
  final String uslSls;
  final String orgIdEx;
  final String token;
  final int selectedIndexD;
  final String pgnJns;

  const UslBaList({
    super.key,
    required this.uslIdEx,
    required this.uslSls,
    required this.orgIdEx,
    required this.token,
    required this.selectedIndexD,
    required this.pgnJns,
  });

  @override
  State<UslBaList> createState() => _UslBaListState();
}

class _UslBaListState extends State<UslBaList> {
  String? uslIdEx;
  String uslSls = "2";

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  int? sortColumnIndex;
  bool isAscending = false;
  bool _isLoading = false;
  bool _isError = false;
  String? errorMessage;
  APIResponseHibah<List<UslBa>>? uslBa;

  final columns = ['No', 'Nama Berkas', 'Berkas'];
  final columnsE = ['No', 'Nama Berkas', 'Berkas', 'Aksi'];

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      uslSls = widget.uslSls;
      _isError = true;
    });
    _fetchUslBa(uslIdEx!);
  }

  _fetchUslBa(String uslIdEx) async {
    uslBa = await service.getUslBa(uslIdEx);
    setState(() {
      if (uslBa!.data!.isEmpty) {
        _isError = true;
      } else {
        _isError = false;
      }
      if (uslBa!.error) {
        _isLoading = false;
        errorMessage = uslBa!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : _isError
            ? Column(
                children: const <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Belum Ada Berita Acara',
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
                      columns: uslSls == "4" ||
                              uslSls == "5" ||
                              uslSls == "6" ||
                              uslSls == "7" ||
                              uslSls == "8"
                          ? getColumns(columnsE)
                          : getColumns(columns),
                      rows: getRows(uslBa, uslSls)),
                ),
              );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(label: Text(column)),
      )
      .toList();

  List<DataRow> getRows(APIResponseHibah<List<UslBa>>? uslBa, String uslSls) =>
      uslBa!.data!.map((UslBa usl) {
        final cells = uslSls == "4" ||
                uslSls == "5" ||
                uslSls == "6" ||
                uslSls == "7" ||
                uslSls == "8"
            ? [
                Text('${usl.no}'),
                Text(usl.uslBaNm),
                ButtonDTP(
                  child: IconButton(
                    iconSize: 20,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrePdf(
                            name: 'Berkas ${usl.uslBaNm}',
                            pdf: usl.uslBaFl,
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
                ButtonDTP(
                  child: IconButton(
                    iconSize: 20,
                    onPressed: () async {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.QUESTION,
                              title: 'Menyetujui',
                              desc: 'Menghapus Berkas Berita Acara',
                              btnOkOnPress: () async {
                                final result = await serviceComp
                                    .uslBaDelete(usl.uslBaIdEx);
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
                                          uslIdEx: widget.uslIdEx,
                                          orgIdEx: widget.orgIdEx,
                                          token: widget.token,
                                          selectedIndexD: widget.selectedIndexD,
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
              ]
            : [
                Text('${usl.no}'),
                Text(usl.uslBaNm),
                ButtonDTP(
                  child: IconButton(
                    iconSize: 20,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrePdf(
                            name: 'Berkas ${usl.uslBaNm}',
                            pdf: usl.uslBaFl,
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
              ];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(data)).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      uslBa!.data!.sort((user1, user2) =>
          compareString(ascending, user1.uslBaNm, user2.uslBaNm));
    } else if (columnIndex == 1) {
      uslBa!.data!.sort((user1, user2) =>
          compareString(ascending, user1.no.toString(), user2.no.toString()));
    }

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
