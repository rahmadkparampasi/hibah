import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/home_screen.dart';
import 'package:SimhegaM/screens/items/sp_icon.dart';
import 'package:SimhegaM/screens/proposal_screen.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DetailPScreen extends StatefulWidget {
  final String token;
  final String uslIdEx;
  final int selectedIndex;
  const DetailPScreen(
      {required this.token,
      required this.uslIdEx,
      required this.selectedIndex,
      Key? key})
      : super(key: key);

  @override
  State<DetailPScreen> createState() => _DetailPScreenState();
}

class _DetailPScreenState extends State<DetailPScreen> {
  late String _token;
  String? _uslIdEx;

  bool _isLoading = false;

  String? errorMessage;

  HibahService get service => GetIt.I<HibahService>();

  Hibah? hibah;

  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    setState(() {
      _token = widget.token;
      _uslIdEx = widget.uslIdEx;
      _isLoading = true;
      _selectedIndex = widget.selectedIndex;
    });
    if (_uslIdEx != null) {
      service.getHibah(_uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double topContainerHeight = 190;
    double height = MediaQuery.of(context).size.height;

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
                  SizedBox(
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
                          child: SizedBox(
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
                            onPressed: () {},
                            child: Container(
                              height: 45,
                              child: Center(
                                child: Row(
                                  children: const <Widget>[
                                    Icon(Icons.book_outlined),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('PROPOSAL'),
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
                        Container(
                          child: ListTile(
                            minLeadingWidth: 0,
                            leading: const SizedBox(
                              height: double.infinity,
                              child: SPIcon(assetName: 'certificate.png'),
                            ),
                            title: const Text(
                              'Nama Proposal',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            subtitle: Text(
                              hibah!.uslNm,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        DefaultTabController(
                          length: 7,
                          child: Column(
                            children: <Widget>[
                              Material(
                                color: Colors.white,
                                child: TabBar(
                                  isScrollable: true,
                                  labelColor: Colors.black,
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  unselectedLabelColor: Colors.grey[400],
                                  unselectedLabelStyle: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17,
                                  ),
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicatorColor: Colors.transparent,
                                  tabs: const <Widget>[
                                    Tab(
                                      child: Text('Proposal'),
                                    ),
                                    Tab(
                                      child: Text('Berkas'),
                                    ),
                                    Tab(
                                      child: Text('Anggaran'),
                                    ),
                                    Tab(
                                      child: Text('Tahapan'),
                                    ),
                                    Tab(
                                      child: Text('Peninjauan'),
                                    ),
                                    Tab(
                                      child: Text('Verifikator'),
                                    ),
                                    Tab(
                                      child: Text('Surat'),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: height * 0.5,
                                child: TabBarView(
                                  children: <Widget>[
                                    ProposalScreen(
                                      uslLb: hibah!.uslLb,
                                      uslTtp: hibah!.uslTtp,
                                    ),
                                    ListView(
                                      children: <Widget>[
                                        Text('Tes'),
                                      ],
                                    ),
                                    ListView(
                                      children: <Widget>[
                                        Text('Tes'),
                                      ],
                                    ),
                                    ListView(
                                      children: <Widget>[
                                        Text('Tes'),
                                      ],
                                    ),
                                    ListView(
                                      children: <Widget>[
                                        Text('Tes'),
                                      ],
                                    ),
                                    ListView(
                                      children: <Widget>[
                                        Text('Tes'),
                                      ],
                                    ),
                                    ListView(
                                      children: <Widget>[
                                        Text('Tes'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          );
  }
}
