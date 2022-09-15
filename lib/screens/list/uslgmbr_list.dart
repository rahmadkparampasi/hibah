import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/items/comp_items.dart';
import 'package:SimhegaM/screens/items/preimg_items.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UslGmbrList extends StatefulWidget {
  final String uslIdEx;

  const UslGmbrList({super.key, required this.uslIdEx});

  @override
  State<UslGmbrList> createState() => _UslGmbrListState();
}

class _UslGmbrListState extends State<UslGmbrList> {
  String? uslIdEx;

  HibahService get service => GetIt.I<HibahService>();

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

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : _isError == false
            ? Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: DataTable(
                    columns: getColumns(columns), rows: getRows(uslGmbr)),
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
      uslGmbr!.data!.map((UslGmbr usl) {
        final cells = [
          Text('${usl.no}'),
          Text(usl.uslGmbrNm),
          ButtonDTP(
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
