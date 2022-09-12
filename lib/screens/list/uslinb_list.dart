import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/items/detail_items.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';

class UslInbList extends StatefulWidget {
  final String uslIdEx;

  const UslInbList({super.key, required this.uslIdEx});

  @override
  State<UslInbList> createState() => _UslInbListState();
}

class _UslInbListState extends State<UslInbList> {
  String? uslIdEx;
  HibahService get service => GetIt.I<HibahService>();

  int? sortColumnIndex;
  bool isAscending = false;
  bool _isLoading = false;
  bool _isError = false;
  String? errorMessage;
  APIResponseHibah<List<UslInb>>? uslInb;

  final columns = ['No', 'Judul', 'Tanggal', 'Jam'];

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      _isError = true;
    });
    _fetchUslInb(uslIdEx!);
  }

  _fetchUslInb(String uslIdEx) async {
    uslInb = await service.getUslInb(uslIdEx);
    setState(() {
      if (uslInb!.data!.isEmpty) {
        _isError = true;
      } else {
        _isError = false;
      }
      if (uslInb!.error) {
        _isLoading = false;
        errorMessage = uslInb!.errorMessage!;
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
                    'Belum Ada Surat Pemberitahuan',
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
                    columns: getColumns(columns), rows: getRows(uslInb)),
              );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(label: Text(column)),
      )
      .toList();

  List<DataRow> getRows(APIResponseHibah<List<UslInb>>? uslInb) =>
      uslInb!.data!.map((UslInb usl) {
        final cells = [
          Text('${usl.no}'),
          Text(usl.inbJdl),
          Text(usl.inbTgl),
          Text(usl.inbJam),
        ];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(data)).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      uslInb!.data!.sort((user1, user2) =>
          compareString(ascending, user1.inbJdl, user2.inbJdl));
    } else if (columnIndex == 1) {
      uslInb!.data!.sort((user1, user2) =>
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
