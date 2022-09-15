import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/items/comp_items.dart';
import 'package:flutter/material.dart';

class UslThpList extends StatefulWidget {
  final APIResponseHibah<List<UslThp>> uslThp;
  const UslThpList({
    Key? key,
    required this.uslThp,
  }) : super(key: key);

  @override
  State<UslThpList> createState() => _UslThpListState();
}

class _UslThpListState extends State<UslThpList> {
  APIResponseHibah<List<UslThp>>? uslThp;
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      uslThp = widget.uslThp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final columns = [
      'No',
      'Tahapan',
      'Tanggal Mulai',
      'Tanggal Akhir',
      'Kategori',
      'Keterangan',
      'Aksi'
    ];
    return ListView(
      children: <Widget>[
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: getColumns(columns), rows: getRows(uslThp))),
        ),
        const SizedBox(
          height: 20,
        )
      ],
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
