import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailOScreen extends StatefulWidget {
  final String token;
  final String uslIdEx;

  final Organisasi organisasi;
  final Hibah hibah;

  final int selectedIndex;
  const DetailOScreen({
    Key? key,
    required this.token,
    required this.uslIdEx,
    this.selectedIndex = 0,
    required this.organisasi,
    required this.hibah,
  }) : super(key: key);

  @override
  State<DetailOScreen> createState() => _DetailOScreenState();
}

class _DetailOScreenState extends State<DetailOScreen> {
  late String _token;
  String? _uslIdEx;
  bool _isLoading = false;

  Organisasi? organisasi;
  Hibah? hibah;

  int? _selectedIndex;

  @override
  void initState() {
    super.initState();

    setState(() {
      _token = widget.token;
      _uslIdEx = widget.uslIdEx;
      // _isLoading = true;
      _selectedIndex = widget.selectedIndex;
      organisasi = widget.organisasi;
      hibah = widget.hibah;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : ListView(
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
                          text: TextSpan(
                            text: hibah!.uslNm,
                            style: const TextStyle(
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
                  ),
                  Positioned(
                    top: 10.0,
                    left: 10.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              token: _token,
                              selectedIndex: _selectedIndex!,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent.withOpacity(0.1),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        shadows: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Transform.translate(
                offset: Offset(0.5, -(height * 0.3 - height * 0.28)),
                child: Container(
                  width: width,
                  padding: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    color: mBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                      right: 30,
                      left: 30,
                      bottom: 20,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          organisasi!.orgNm,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          organisasi!.riNm,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buildSocialIcon(
                              FontAwesomeIcons.phone,
                              'tel',
                              organisasi!.orgHp,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            buildSocialIcon(
                              FontAwesomeIcons.message,
                              'sms',
                              organisasi!.orgHp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Akta Notaris',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      organisasi!.orgAkt,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Tanggal Terbentuk',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      organisasi!.orgTgl,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Alamat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      organisasi!.orgAlt,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Telepon',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      organisasi!.orgHp,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      organisasi!.orgMail,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Rekening',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      organisasi!.orgRek,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  Widget buildSocialIcon(IconData icon, String scheme, String to) =>
      CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 25,
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              final Uri launcUri = Uri(scheme: scheme, path: to);
              if (await canLaunchUrl(launcUri)) {
                await launchUrl(launcUri);
              }
            },
            child: Center(
              child: Icon(
                icon,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
}
