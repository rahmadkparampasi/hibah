import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/detail_screen.dart';
import 'package:SimhegaM/screens/items/comp_items.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UslVerList extends StatefulWidget {
  final String uslIdEx;
  final String uslSls;
  final String orgIdEx;
  final String token;
  final int selectedIndexD;

  const UslVerList({
    super.key,
    required this.uslIdEx,
    required this.uslSls,
    required this.orgIdEx,
    required this.token,
    required this.selectedIndexD,
  });

  @override
  State<UslVerList> createState() => _UslVerListState();
}

class _UslVerListState extends State<UslVerList> {
  String? uslIdEx;
  String uslSls = "2";

  HibahService get service => GetIt.I<HibahService>();

  int? sortColumnIndex;
  bool isAscending = false;
  bool _isLoading = false;
  bool _isError = false;
  String? errorMessage;
  APIResponseHibah<List<UslVer>>? uslVer;

  final columns = ['No', 'Nama', 'Jabatan'];
  final columnsE = ['No', 'Nama', 'Jabatan', 'Aksi'];

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      uslSls = widget.uslSls;
      _isError = true;
    });
    _fetchUslVer(uslIdEx!);
  }

  _fetchUslVer(String uslIdEx) async {
    uslVer = await service.getUslVer(uslIdEx);
    setState(() {
      if (uslVer!.data!.isEmpty) {
        _isError = true;
      } else {
        _isError = false;
      }
      if (uslVer!.error) {
        _isLoading = false;
        errorMessage = uslVer!.errorMessage!;
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
                    'Belum Ada Verifikator',
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
                    columns: getColumns(uslSls != "2" ? columns : columnsE),
                    rows: getRows(uslVer),
                  ),
                ),
              );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(label: Text(column)),
      )
      .toList();

  List<DataRow> getRows(APIResponseHibah<List<UslVer>>? uslVer) => uslSls != "2"
      ? uslVer!.data!.map((UslVer usl) {
          final cells = [
            Container(width: 20, child: Text('${usl.no}')),
            Container(width: 100, child: Text(usl.pgwNm)),
            Container(width: 100, child: Text(usl.pgwJbt)),
          ];
          return DataRow(cells: getCells(cells));
        }).toList()
      : uslVer!.data!.map((UslVer usl) {
          final cells = [
            Container(width: 20, child: Text('${usl.no}')),
            Container(width: 100, child: Text(usl.pgwNm)),
            Container(width: 100, child: Text(usl.pgwJbt)),
            Container(
              width: 40,
              child: ButtonDTP(
                child: IconButton(
                  iconSize: 20,
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.QUESTION,
                      title: 'Menyetujui',
                      desc: 'Menghapus Anggota Verifikator',
                      btnOkOnPress: () async {
                        final result =
                            await service.uslVerDelete(usl.uslVerIdEx);
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
                                  orgIdEx: widget.orgIdEx,
                                  token: widget.token,
                                  selectedIndexD: widget.selectedIndexD,
                                ),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ).show();
                      },
                      btnCancelOnPress: () {},
                    ).show();
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
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
      uslVer!.data!.sort(
          (user1, user2) => compareString(ascending, user1.pgwNm, user2.pgwNm));
    } else if (columnIndex == 1) {
      uslVer!.data!.sort((user1, user2) =>
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
