import 'package:SimhegaM/screens/detail_screen.dart';
import 'package:SimhegaM/screens/home_screen.dart';
import 'package:SimhegaM/screens/items/comp_items.dart';
import 'package:flutter/material.dart';
import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:get_it/get_it.dart';

class ProsesScreen extends StatefulWidget {
  final String token;
  final String pgnJns;
  final int selectedIndex;

  const ProsesScreen({
    super.key,
    required this.token,
    required this.selectedIndex,
    required this.pgnJns,
  });

  @override
  State<ProsesScreen> createState() => _ProsesScreenState();
}

class _ProsesScreenState extends State<ProsesScreen> {
  late String _token;
  late String _pgnJns;

  HibahService get service => GetIt.I<HibahService>();

  APIResponseHibah<List<HibahForList>>? _apiResponseHibah;

  bool _isLoading = false;
  int? _selectedIndex;

  String errorMessage = 'Terjadi Masalah, Silahkan Muat Kembali';

  @override
  void initState() {
    super.initState();
    _fetchHibah();
    setState(() {
      _token = widget.token;
      _pgnJns = widget.pgnJns;
      _selectedIndex = widget.selectedIndex;
      _isLoading = false;
    });
  }

  _fetchHibah() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponseHibah = await service.getHibahListPage();
    setState(() {
      if (_apiResponseHibah!.error) {
        _isLoading = false;
        errorMessage = _apiResponseHibah!.errorMessage!;
      } else {
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ListView(
      children: <Widget>[
        TopHomeScreen(
          height: height,
          width: width,
          title: 'Data Pengajuan Dengan Status Sementara Proses',
        ),
        Transform.translate(
          offset: Offset(0.5, -(height * 0.3 - height * 0.28)),
          child: Container(
            width: width,
            height: 20,
            decoration: const BoxDecoration(
              color: mBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        ),
        Builder(builder: (_) {
          if (_isLoading) {
            return Column(
              children: const <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ],
            );
          }
          if (_apiResponseHibah == null) {
            return Center(
              child: Column(
                children: <Widget>[
                  Text(errorMessage),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            token: _token,
                            selectedIndex: _selectedIndex!,
                            pgnJns: _pgnJns,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Muat Kembali',
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 5, right: 5),
              separatorBuilder: (_, __) => const Divider(
                    height: 1,
                    color: Colors.green,
                  ),
              itemBuilder: (_, index) {
                return Card(
                  elevation: 3,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        _apiResponseHibah!.data![index].no.toString(),
                      ),
                    ),
                    title: Text(
                      '${_apiResponseHibah!.data![index].orgNama} - ${_apiResponseHibah!.data![index].uslNm}',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                        '${_apiResponseHibah!.data![index].anggaran} - ${_apiResponseHibah!.data![index].uslHsl}'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            token: _token,
                            uslIdEx: _apiResponseHibah!.data![index].uslIdEx,
                            orgIdEx: _apiResponseHibah!.data![index].uslOrg,
                            selectedIndex: _selectedIndex!,
                            pgnJns: _pgnJns,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              itemCount: _apiResponseHibah!.data!.length);
        }),
      ],
    );
  }
}
