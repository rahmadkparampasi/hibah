import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/detail_screen.dart';
import 'package:SimhegaM/screens/items/comp_items.dart';
import 'package:SimhegaM/screens/items/preimg_items.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:SimhegaM/services/hibahcomp_services.dart';
import 'package:SimhegaM/widgets/scrollable_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UslGmbrList extends StatefulWidget {
  final String uslIdEx;
  final String uslSls;
  final String orgIdEx;
  final String token;
  final int selectedIndexD;

  const UslGmbrList({
    super.key,
    required this.uslIdEx,
    required this.uslSls,
    required this.orgIdEx,
    required this.token,
    required this.selectedIndexD,
  });

  @override
  State<UslGmbrList> createState() => _UslGmbrListState();
}

class _UslGmbrListState extends State<UslGmbrList> {
  String? uslIdEx;
  String uslSls = "2";

  HibahService get service => GetIt.I<HibahService>();
  HibahCompService get serviceComp => GetIt.I<HibahCompService>();

  int? sortColumnIndex;
  bool isAscending = false;
  bool _isLoading = false;
  bool _isError = false;
  String? errorMessage;
  APIResponseHibah<List<UslGmbr>>? uslGmbr;

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      uslSls = widget.uslSls;
      _isError = true;
    });
    _fetchUslGmbr(uslIdEx!);
  }

  _fetchUslGmbr(String uslIdEx) async {
    uslGmbr = await service.getUslGmbr(uslIdEx);
    setState(() {
      if (uslGmbr!.data!.isEmpty) {
        _isError = true;
      } else {
        _isError = false;
      }
      if (uslGmbr!.error) {
        _isLoading = false;
        errorMessage = uslGmbr!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final columns = ['No', 'Nama Gambar', 'Berkas'];
    final columnsE = ['No', 'Nama Gambar', 'Berkas', 'Aksi'];

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : _isError == false
            ? Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: getColumns(uslSls != "2" ? columns : columnsE),
                    rows: getRows(uslGmbr),
                  ),
                ),
              )
            : Column(
                children: const <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Belum Ada Dokumentasi Lapangan',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  Divider(),
                ],
              );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(label: Text(column)),
      )
      .toList();

  List<DataRow> getRows(APIResponseHibah<List<UslGmbr>>? uslGmbr) =>
      uslSls != "2"
          ? uslGmbr!.data!.map((UslGmbr usl) {
              final cells = [
                Container(width: 20, child: Text('${usl.no}')),
                Container(width: 100, child: Text(usl.uslGmbrNm)),
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
                              name: 'Foto ${usl.uslGmbrNm}',
                              img: usl.uslGmbrFl,
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
              return DataRow(cells: getCells(cells));
            }).toList()
          : uslGmbr!.data!.map((UslGmbr usl) {
              final cells = [
                Container(width: 20, child: Text('${usl.no}')),
                Container(width: 100, child: Text(usl.uslGmbrNm)),
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
                              name: 'Foto ${usl.uslGmbrNm}',
                              img: usl.uslGmbrFl,
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
                              desc: 'Menghapus Dokumentasi Lapangan',
                              btnOkOnPress: () async {
                                final result = await serviceComp
                                    .uslGmbrDelete(usl.uslGmbrIdEx);
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
              return DataRow(cells: getCells(cells));
            }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(data)).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      uslGmbr!.data!.sort((user1, user2) =>
          compareString(ascending, user1.uslGmbrNm, user2.uslGmbrNm));
    } else if (columnIndex == 1) {
      uslGmbr!.data!.sort((user1, user2) =>
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
