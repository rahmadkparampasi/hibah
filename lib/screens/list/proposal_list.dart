import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/items/sp_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ProposalList extends StatelessWidget {
  String uslLb;
  String uslTtp;
  APIResponseHibah<List<UslM>>? uslM;
  APIResponseHibah<List<UslT>>? uslT;

  ProposalList(
      {Key? key,
      required this.uslLb,
      required this.uslTtp,
      required this.uslM,
      required this.uslT})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final columns = [
      'No',
      'Maksud',
    ];
    final columnsT = [
      'No',
      'Tujuan',
    ];
    return ListView(
      children: <Widget>[
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  minLeadingWidth: 0,
                  leading: const SizedBox(
                    height: double.infinity,
                    child: SPIcon(assetName: 'story.png'),
                  ),
                  title: const Text(
                    'Latar Belakang',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  subtitle: Html(data: uslLb),
                ),
              ),
              Divider(),
              Container(
                color: Colors.white,
                child: ListTile(
                  minLeadingWidth: 0,
                  leading: const SizedBox(
                    height: double.infinity,
                    child: SPIcon(assetName: 'car.png'),
                  ),
                  title: const Text(
                    'Maksud Proposal',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  subtitle: uslM == null
                      ? const Text('Tidak Ada Maksud Proposal')
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              DataTable(
                                columns: getColumns(columns),
                                rows: getRows(uslM),
                              )
                            ],
                          ),
                        ),
                ),
              ),
              Divider(),
              Container(
                color: Colors.white,
                child: ListTile(
                  minLeadingWidth: 0,
                  leading: const SizedBox(
                    height: double.infinity,
                    child: SPIcon(assetName: 'dest.png'),
                  ),
                  title: const Text(
                    'Tujuam Proposal',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  subtitle: uslT == null
                      ? const Text('Tidak Ada Tujuan Proposal')
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              DataTable(
                                columns: getColumns(columnsT),
                                rows: getRowsT(uslT),
                              )
                            ],
                          ),
                        ),
                ),
              ),
              Divider(),
              Container(
                child: ListTile(
                  minLeadingWidth: 0,
                  leading: const SizedBox(
                    height: double.infinity,
                    child: SPIcon(assetName: 'check.png'),
                  ),
                  title: const Text(
                    'Penutup',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  subtitle: Html(data: uslTtp),
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

  List<DataRow> getRows(APIResponseHibah<List<UslM>>? uslM) =>
      uslM!.data!.map((UslM usl) {
        final cells = [
          Text('${usl.no}'),
          Text(usl.uslMT),
        ];
        return DataRow(cells: getCells(cells));
      }).toList();
  List<DataRow> getRowsT(APIResponseHibah<List<UslT>>? uslT) =>
      uslT!.data!.map((UslT usl) {
        final cells = [
          Text('${usl.no}'),
          Text(usl.uslTT),
        ];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(data)).toList();
}
