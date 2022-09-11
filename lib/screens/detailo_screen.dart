import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/home_screen.dart';
import 'package:SimhegaM/screens/items/detail_items.dart';
import 'package:SimhegaM/screens/items/pengdt_items.dart';
import 'package:SimhegaM/screens/items/sp_icon.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailOScreen extends StatefulWidget {
  final String token;
  final String orgIdEx;

  final int selectedIndex;
  const DetailOScreen({
    Key? key,
    required this.token,
    required this.orgIdEx,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<DetailOScreen> createState() => _DetailOScreenState();
}

class _DetailOScreenState extends State<DetailOScreen> {
  late String _token;
  String? _orgIdEx;
  bool _isLoading = false;
  HibahService get service => GetIt.I<HibahService>();

  Organisasi? organisasi;

  APIResponsePengOrganisasi<List<PengOrganisasiForList>>? pengOrganisasi;

  int? _selectedIndex;

  @override
  void initState() {
    super.initState();

    setState(() {
      _token = widget.token;
      _orgIdEx = widget.orgIdEx;
      _isLoading = true;
      _selectedIndex = widget.selectedIndex;
    });
    if (_orgIdEx != null) {
      service.getOrganisasi(_orgIdEx!).then((value) {
        setState(() {
          organisasi = value.data;
          _isLoading = false;
        });
        if (organisasi != null) {
          _fetchPengOrg(_orgIdEx!);
        }
      });
    }
  }

  _fetchPengOrg(String orgIdEx) async {
    setState(() {
      _isLoading = true;
    });
    pengOrganisasi = await service.getPengOrganisasiList(orgIdEx);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double topContainerHeight = 190;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: topContainerHeight,
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              height: topContainerHeight * .58,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/def_head_1.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.blue.withOpacity(1.0),
                                        Colors.blue.withOpacity(0.5),
                                        Colors.blue.withOpacity(0.1),
                                        Colors.blue.withOpacity(0.5),
                                        Colors.blue.withOpacity(1.0),
                                      ],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft),
                                ),
                              ),
                            ),
                            Container(
                              height: topContainerHeight * .42,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 145.0,
                          top: 20.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 145,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  const Image(
                                    image:
                                        AssetImage("assets/images/favicon.png"),
                                    height: 40,
                                  ),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Container(
                            height: 132,
                            width: 132,
                            child: Card(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/images/def_head_1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 22,
                          left: 180,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              final Uri launcUri =
                                  Uri(scheme: 'tel', path: organisasi!.orgHp);
                              if (await canLaunchUrl(launcUri)) {
                                await launchUrl(launcUri);
                              }
                            },
                            child: Container(
                              height: 45,
                              child: Center(
                                child: Row(
                                  children: const <Widget>[
                                    Icon(Icons.phone),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('TELEPON'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 22,
                          left: 310,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              final Uri launcUri =
                                  Uri(scheme: 'sms', path: organisasi!.orgHp);
                              if (await canLaunchUrl(launcUri)) {
                                await launchUrl(launcUri);
                              }
                            },
                            child: Container(
                              height: 45,
                              child: Center(
                                child: Row(
                                  children: const <Widget>[
                                    Icon(Icons.mail_outlined),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('SMS'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        DetailItem(
                          icon: "site.png",
                          title: 'Organisasi',
                          subtitle:
                              '${organisasi!.riNm} - ${organisasi!.orgNm}',
                          isLast: false,
                        ),
                        DetailItem(
                          icon: "lawBook.png",
                          title: 'Akta Notaris',
                          subtitle: organisasi!.orgAkt,
                          isLast: false,
                        ),
                        DetailItem(
                          icon: "date.png",
                          title: 'Tanggal Terbentuk',
                          subtitle: organisasi!.orgTgl,
                          isLast: false,
                        ),
                        DetailItem(
                          icon: "place.png",
                          title: 'Alamat',
                          subtitle: organisasi!.orgAlt,
                          isLast: false,
                        ),
                        DetailItem(
                          icon: "contact.png",
                          title: 'Kontak',
                          subtitle:
                              '${organisasi!.orgHp}/${organisasi!.orgMail}',
                          isLast: false,
                        ),
                        DetailItem(
                          icon: "wallet.png",
                          title: 'Rekening',
                          subtitle: organisasi!.orgRek,
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Pengurus Organisasi',
                          style: TextStyle(color: Colors.black54, fontSize: 17),
                        ),
                        pengOrganisasi == null
                            ? Column(
                                children: const <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Belum Ada Pengurus',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    PengDt(pengOrganisasi: pengOrganisasi),
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          );
  }
}
