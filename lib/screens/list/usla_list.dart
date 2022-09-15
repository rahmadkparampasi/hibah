import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UslAList extends StatefulWidget {
  final String uslIdEx;
  const UslAList({super.key, required this.uslIdEx});

  @override
  State<UslAList> createState() => _UslAListState();
}

class _UslAListState extends State<UslAList> {
  String? uslIdEx;

  int? sortColumnIndex;
  bool isAscending = false;
  bool _isLoading = false;
  bool _isError = false;
  bool _isErrorStj = false;
  bool _isErrorAng = false;

  final columns = [
    'No',
    'Uraian',
    'Volume',
    'Satuan',
    'Harga Satuan',
    'Total Harga'
  ];

  String? errorMessage;
  HibahService get service => GetIt.I<HibahService>();

  APIResponseHibah<List<UslA>>? uslA;

  @override
  void initState() {
    super.initState();
    setState(() {
      uslIdEx = widget.uslIdEx;
      _isError = true;
      _isErrorStj = true;
      _isErrorAng = true;
    });
    _fetchUslA(uslIdEx!);
    _fetchAnggaranStj(uslIdEx!);
    _fetchAnggaran(uslIdEx!);
  }

  _fetchUslA(String uslIdEx) async {
    uslA = await service.getUslA(uslIdEx);
    setState(() {
      if (uslA!.data!.isEmpty) {
        _isError = true;
      } else {
        _isError = false;
      }
      if (uslA!.error) {
        _isLoading = false;
        errorMessage = uslA!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  APIResponseHibah<Anggaran>? anggaran;
  _fetchAnggaran(String uslIdEx) async {
    anggaran = await service.getAnggaran(uslIdEx);
    setState(() {
      if (anggaran!.data!.anggaran == '') {
        _isErrorAng = true;
      } else {
        _isErrorAng = false;
      }
      if (anggaran!.error) {
        _isLoading = false;
        errorMessage = uslA!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  APIResponseHibah<AnggaranStj>? anggaranStj;
  _fetchAnggaranStj(String uslIdEx) async {
    anggaranStj = await service.getAnggaranStj(uslIdEx);
    setState(() {
      if (anggaranStj!.data!.anggaran == '') {
        _isErrorStj = true;
      } else {
        _isErrorStj = false;
      }
      if (anggaranStj!.error) {
        _isLoading = false;
        errorMessage = uslA!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _isError
            ? ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      'Belum Ada Anggaran Yang Diusulkan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              )
            : ListView(
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
                  uslA == null
                      ? const Center(
                          child: Text('Belum Ada Anggaran Yang Diusulkan'),
                        )
                      : Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                DataTable(
                                    columns: getColumns(columns),
                                    rows: getRows(uslA))
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
                        _isErrorAng
                            ? const Text(
                                'Belum Ada',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                anggaran!.data!.anggaran,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        const SizedBox(
                          height: 5,
                        ),
                        _isErrorAng
                            ? const Text(
                                'Tidak Ada Keterangan',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              )
                            : Text(
                                anggaran!.data!.anggaranb,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
                  _isErrorStj
                      ? const Center(
                          child: Text('Belum Ada Anggaran Disetujui'),
                        )
                      : Center(
                          widthFactor: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              const Text(
                                'Anggaran Disetujui : ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                anggaranStj!.data!.anggaran,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                anggaranStj!.data!.anggaranb,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 20,
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
