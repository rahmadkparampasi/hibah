import 'package:flutter/material.dart';
import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:get_it/get_it.dart';

class ProsesScreen extends StatefulWidget {
  final String token;

  const ProsesScreen({required this.token});

  @override
  State<ProsesScreen> createState() => _ProsesScreenState();
}

class _ProsesScreenState extends State<ProsesScreen> {
  late String _token;

  HibahService get service => GetIt.I<HibahService>();

  APIResponseHibah<List<HibahForList>>? _apiResponseHibah;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchHibah();
    setState(() {
      _token = widget.token;
    });
  }

  _fetchHibah() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponseHibah = await service.getHibahListPage();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ListView(
      physics: const ClampingScrollPhysics(),
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: height * 0.25,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/def_head_1.png"),
                    fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.blue.withOpacity(1.0),
                    Colors.blue.withOpacity(0.5),
                    Colors.blue.withOpacity(0.1),
                    Colors.blue.withOpacity(0.5),
                    Colors.blue.withOpacity(1.0),
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              top: 50.0,
              child: Column(
                children: <Widget>[
                  const Image(
                      image: AssetImage("assets/images/favicon.png"),
                      height: 50),
                  RichText(
                    text: const TextSpan(
                      text: 'SI-MHEGA',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 10.0,
                            offset: Offset.zero,
                          )
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'Data Pengajuan Dengan Status Sementara Proses',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 10.0,
                            offset: Offset.zero,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
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
            return const SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(),
            );
          }
          if (_apiResponseHibah!.error) {
            return Center(
              child: Text(_apiResponseHibah!.errorMessage!),
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
                return Dismissible(
                  key: ValueKey(_apiResponseHibah!.data![index].orgNama),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                      context: context,
                      builder: (_) => const ProsesScreen(
                        token: '',
                      ),
                    );
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.only(left: 16),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child:
                            Text(_apiResponseHibah!.data![index].no.toString()),
                      ),
                      title: Text(
                        '${_apiResponseHibah!.data![index].orgNama} - ${_apiResponseHibah!.data![index].uslNm}',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      subtitle: Text(
                          '${_apiResponseHibah!.data![index].anggaran} - ${_apiResponseHibah!.data![index].uslHsl}'),
                      onTap: () {},
                    ),
                  ),
                );
              },
              itemCount: _apiResponseHibah!.data!.length);
        }),
      ],
    );
  }
}
