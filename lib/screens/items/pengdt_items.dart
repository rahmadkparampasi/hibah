import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/items/detail_items.dart';
import 'package:flutter/material.dart';

class PengDt extends StatefulWidget {
  final APIResponsePengOrganisasi<List<PengOrganisasiForList>>? pengOrganisasi;

  const PengDt({Key? key, required this.pengOrganisasi}) : super(key: key);

  @override
  State<PengDt> createState() => _PengDtState();
}

class _PengDtState extends State<PengDt> {
  APIResponsePengOrganisasi<List<PengOrganisasiForList>>? _pengOrganisasi;
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();
    _pengOrganisasi = widget.pengOrganisasi;
  }

  @override
  Widget build(BuildContext context) {
    final columns = [
      'No',
      'Nama',
      'Jabatan',
      'No. KTP',
      'Jenis Kelamin',
      'Kontak',
      'Foto'
    ];
    return DataTable(
        columns: getColumns(columns), rows: getRows(_pengOrganisasi));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(label: Text(column)),
      )
      .toList();

  List<DataRow> getRows(
          APIResponsePengOrganisasi<List<PengOrganisasiForList>>?
              pengOrganisasi) =>
      pengOrganisasi!.data!.map((PengOrganisasiForList user) {
        final cells = [
          Text('${user.no}'),
          Text(user.pengNm),
          Text(user.strNm),
          Text(user.pengNik),
          Text(user.pengJk),
          ButtonDT(
            text: user.pengHp,
          ),
          ButtonDTP(
            img: user.pengPic,
            name: 'Foto ${user.pengNm}',
          ),
        ];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(data)).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      _pengOrganisasi!.data!.sort((user1, user2) =>
          compareString(ascending, user1.pengNm, user2.pengNm));
    } else if (columnIndex == 1) {
      _pengOrganisasi!.data!.sort((user1, user2) =>
          compareString(ascending, user1.pengJk, user2.pengJk));
    }

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
