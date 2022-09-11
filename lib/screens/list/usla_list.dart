import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UslAList extends StatefulWidget {
  final APIResponseHibah<List<UslA>> uslA;
  final String ttlUsl;
  final String ttlUslB;
  final String ttlUslStj;
  final String ttlUslStjB;
  const UslAList({
    Key? key,
    required this.uslA,
    required this.ttlUsl,
    required this.ttlUslB,
    required this.ttlUslStj,
    required this.ttlUslStjB,
  }) : super(key: key);

  @override
  State<UslAList> createState() => _UslAListState();
}

class _UslAListState extends State<UslAList> {
  APIResponseHibah<List<UslA>>? uslA;
  String? ttlUsl;
  String? ttlUslB;

  String? ttlUslStj;
  String? ttlUslStjB;

  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      uslA = widget.uslA;
      ttlUsl = widget.ttlUsl;
      ttlUslB = widget.ttlUslB;
      ttlUslStj = widget.ttlUslStj;
      ttlUslStjB = widget.ttlUslStjB;
    });
  }

  @override
  Widget build(BuildContext context) {
    final columns = [
      'No',
      'Uraian',
      'Volume',
      'Satuan',
      'Harga Satuan',
      'Total Harga'
    ];
    return ListView(
      children: <Widget>[
        const SizedBox(
          height: 5,
        ),
        Container(
          child: const Center(
            child: Text(
              'Anggaran Pengusulan',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 17),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                DataTable(columns: getColumns(columns), rows: getRows(uslA))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          widthFactor: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              const Text(
                'Total Pengusulan : ',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              ttlUsl != null
                  ? Text(
                      ttlUsl!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(
                      'Belum Ada',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
              const SizedBox(
                height: 5,
              ),
              ttlUslB != null
                  ? Text(
                      ttlUslB!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    )
                  : const Text(
                      'Tidak Ada Keterangan',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(),
        const SizedBox(
          height: 5,
        ),
        Center(
          widthFactor: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              const Text(
                'Anggaran Disetujui : ',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              ttlUslStj != null
                  ? Text(
                      ttlUslStj!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(
                      'Belum Ada',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
              const SizedBox(
                height: 5,
              ),
              ttlUslStjB != null
                  ? Text(
                      ttlUslStjB!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    )
                  : const Text(
                      'Tidak Ada Keterangan',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(label: Text(column)),
      )
      .toList();

  List<DataRow> getRows(APIResponseHibah<List<UslA>>? uslA) =>
      uslA!.data!.map((UslA usl) {
        final cells = [
          Text('${usl.no}'),
          Text(usl.uslAU),
          Text(usl.uslAV),
          Text(usl.uslAStn),
          Text(usl.uslANS),
          Text(usl.uslAHrg),
        ];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(data)).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      uslA!.data!.sort((user1, user2) =>
          compareString(ascending, user1.no.toString(), user2.no.toString()));
    } else if (columnIndex == 1) {
      uslA!.data!.sort(
          (user1, user2) => compareString(ascending, user1.uslAU, user2.uslAU));
    }

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
