import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/items/sp_icon.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get_it/get_it.dart';

class PropList extends StatefulWidget {
  String uslLb;
  String uslTtp;
  String uslIdEx;

  PropList(
      {Key? key,
      required this.uslLb,
      required this.uslTtp,
      required this.uslIdEx})
      : super(key: key);

  @override
  State<PropList> createState() => _PropListState();
}

class _PropListState extends State<PropList> {
  String? uslLb;
  String? uslTtp;
  String? _uslIdEx;

  bool _isLoading = false;
  String? errorMessage;

  HibahService get service => GetIt.I<HibahService>();

  APIResponseHibah<List<UslM>>? uslM;

  _fetchUslM(String uslIdEx) async {
    uslM = await service.getUslM(uslIdEx);
    setState(() {
      if (uslM!.error) {
        _isLoading = false;
        errorMessage = uslM!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  APIResponseHibah<List<UslT>>? uslT;

  _fetchUslT(String uslIdEx) async {
    uslT = await service.getUslT(uslIdEx);
    setState(() {
      if (uslT!.error) {
        _isLoading = false;
        errorMessage = uslT!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  final columns = [
    'No',
    'Maksud',
  ];
  final columnsT = [
    'No',
    'Tujuan',
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      uslLb = widget.uslLb;
      uslTtp = widget.uslTtp;
      _uslIdEx = widget.uslIdEx;
      if (_uslIdEx != null) {
        _fetchUslM(_uslIdEx!);
        _fetchUslT(_uslIdEx!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
