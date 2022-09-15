import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UslVerList extends StatefulWidget {
  final String uslIdEx;

  const UslVerList({super.key, required this.uslIdEx});

  @override
  State<UslVerList> createState() => _UslVerListState();
}

class _UslVerListState extends State<UslVerList> {
  String? uslIdEx;
  HibahService get service => GetIt.I<HibahService>();

  int? sortColumnIndex;
  bool isAscending = false;
  bool _isLoading = false;
  bool _isError = false;
  String? errorMessage;
  APIResponseHibah<List<UslVer>>? uslVer;

  final columns = ['No', 'Nama', 'Jabatan'];

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
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
                child: DataTable(
                    columns: getColumns(columns), rows: getRows(uslVer)),
              );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(label: Text(column)),
      )
      .toList();

  List<DataRow> getRows(APIResponseHibah<List<UslVer>>? uslVer) =>
      uslVer!.data!.map((UslVer usl) {
        final cells = [
          Text('${usl.no}'),
          Text(usl.pgwNm),
          Text(usl.pgwJbt),
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
