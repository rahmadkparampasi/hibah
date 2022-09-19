import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/items/comp_items.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UslThpList extends StatefulWidget {
  final String uslIdEx;
  const UslThpList({super.key, required this.uslIdEx});

  @override
  State<UslThpList> createState() => _UslThpListState();
}

class _UslThpListState extends State<UslThpList> {
  String? uslIdEx;
  HibahService get service => GetIt.I<HibahService>();

  int? sortColumnIndex;
  bool isAscending = false;
  bool _isLoading = false;
  bool _isError = false;
  String? errorMessage;

  final columns = [
    'No',
    'Tahapan',
    'Tanggal Mulai',
    'Tanggal Akhir',
    'Kategori',
    'Keterangan',
    'Aksi'
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      _isError = true;
    });
    _fetchUslThp(uslIdEx!);
  }

  APIResponseHibah<List<UslThp>>? uslThp;

  _fetchUslThp(String uslIdEx) async {
    uslThp = await service.getUslThp(uslIdEx);
    setState(() {
      if (uslThp!.data!.isEmpty) {
        _isError = true;
      } else {
        _isError = false;
      }
      if (uslThp!.error) {
        _isLoading = false;
        errorMessage = uslThp!.errorMessage!;
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
                    'Belum Ada Tahapan',
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
                  child:
                  DataTable(
                  columns: getColumns(columns),
                  rows: getRows(
                    uslThp,
                  ),
                ) ,
                ),
              );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(label: Text(column)),
      )
      .toList();

  List<DataRow> getRows(APIResponseHibah<List<UslThp>>? uslThp) =>
      uslThp!.data!.map((UslThp usl) {
        final cells = [
          SizedBox(width: 5, child: Text('${usl.no}')),
          SizedBox(width: 150, child: Text(usl.uslThpNm)),
          SizedBox(width: 100, child: Text(usl.uslThpTglM)),
          SizedBox(width: 100, child: Text(usl.uslThpTglA)),
          SizedBox(width: 60, child: Text(usl.uslThpJns)),
          SizedBox(width: 60, child: Text(usl.uslThpKet)),
          SizedBox(
            width: 40,
            child: ButtonDTP(
              child: IconButton(
                iconSize: 20,
                onPressed: () {},
                icon: const Icon(
                  Icons.change_circle_outlined,
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
      uslThp!.data!.sort((user1, user2) =>
          compareString(ascending, user1.uslThpNm, user2.uslThpNm));
    } else if (columnIndex == 1) {
      uslThp!.data!.sort((user1, user2) =>
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
