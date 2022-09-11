import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/items/detail_items.dart';
import 'package:SimhegaM/screens/items/prepdf_items.dart';

import 'package:flutter/material.dart';

class UslBrksList extends StatefulWidget {
  final APIResponseHibah<List<UslBrks>> uslBrks;

  const UslBrksList({Key? key, required this.uslBrks}) : super(key: key);

  @override
  State<UslBrksList> createState() => _UslBrksListState();
}

class _UslBrksListState extends State<UslBrksList> {
  APIResponseHibah<List<UslBrks>>? uslBrks;
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      uslBrks = widget.uslBrks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final columns = ['No', 'Nama Berkas', 'Berkas'];
    return ListView(
      children: <Widget>[
        const SizedBox(
          height: 5,
        ),
        Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child:
                DataTable(columns: getColumns(columns), rows: getRows(uslBrks)))
      ],
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(label: Text(column)),
      )
      .toList();

  List<DataRow> getRows(APIResponseHibah<List<UslBrks>>? uslBrks) =>
      uslBrks!.data!.map((UslBrks user) {
        final cells = [
          Text('${user.no}'),
          Text(user.brksNm),
          ButtonDTP(
            child: IconButton(
              iconSize: 20,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrePdf(
                      name: 'Berkas ${user.brksNm}',
                      pdf: user.uslBrksFl,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.picture_as_pdf,
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
      uslBrks!.data!.sort((user1, user2) =>
          compareString(ascending, user1.brksNm, user2.brksNm));
    } else if (columnIndex == 1) {
      uslBrks!.data!.sort((user1, user2) =>
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
