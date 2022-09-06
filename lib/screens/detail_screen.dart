import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/home_screen.dart';
import 'package:SimhegaM/screens/proposal_screen.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

class DetailScreen extends StatefulWidget {
  final String token;
  final String uslIdEx;
  final int selectedIndex;

  const DetailScreen({
    required this.token,
    required this.uslIdEx,
    required this.selectedIndex,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _selectedIndexD = 0;
  late String _token;
  String? _uslIdEx;

  bool _isLoading = false;

  String? errorMessage;

  HibahService get service => GetIt.I<HibahService>();

  Hibah? hibah;

  int? _selectedIndex;

  late var options = [];

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return hibah == null
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : Scaffold(
            body: ListView(
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
                    child: Column(
                      children: <Widget>[
                        DefaultTabController(
                          length: 7,
                          child: Column(
                            children: <Widget>[
                              Material(
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
                                      uslLb: hibah != null
                                          ? hibah!.uslLb
                                          : 'Loading',
                                      uslTtp: hibah != null
                                          ? hibah!.uslTtp
                                          : 'Loading',
                                    ),
                                    ProposalScreen(
                                      uslLb: hibah != null
                                          ? hibah!.uslLb
                                          : 'Loading',
                                      uslTtp: hibah != null
                                          ? hibah!.uslTtp
                                          : 'Loading',
                                    ),
                                    ProposalScreen(
                                      uslLb: hibah != null
                                          ? hibah!.uslLb
                                          : 'Loading',
                                      uslTtp: hibah != null
                                          ? hibah!.uslTtp
                                          : 'Loading',
                                    ),
                                    ProposalScreen(
                                      uslLb: hibah != null
                                          ? hibah!.uslLb
                                          : 'Loading',
                                      uslTtp: hibah != null
                                          ? hibah!.uslTtp
                                          : 'Loading',
                                    ),
                                    ProposalScreen(
                                      uslLb: hibah != null
                                          ? hibah!.uslLb
                                          : 'Loading',
                                      uslTtp: hibah != null
                                          ? hibah!.uslTtp
                                          : 'Loading',
                                    ),
                                    ProposalScreen(
                                      uslLb: hibah != null
                                          ? hibah!.uslLb
                                          : 'Loading',
                                      uslTtp: hibah != null
                                          ? hibah!.uslTtp
                                          : 'Loading',
                                    ),
                                    ProposalScreen(
                                      uslLb: hibah != null
                                          ? hibah!.uslLb
                                          : 'Loading',
                                      uslTtp: hibah != null
                                          ? hibah!.uslTtp
                                          : 'Loading',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40.0,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.book),
                                  label: const Text('Proposal'),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.print),
                                  label: const Text('BAP Peninjauan Lapangan'),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.print),
                                  label: const Text(
                                      'Hasil Penelitian Kelengkapan Administrasi'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
            bottomNavigationBar: Container(
              height: 60,
              decoration: BoxDecoration(
                color: mFillColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 15,
                      offset: const Offset(0, 5))
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 0
                        ? SvgPicture.asset(
                            'assets/icons/book_colored.svg',
                            height: 20,
                          )
                        : SvgPicture.asset(
                            'assets/icons/book.svg',
                            height: 20,
                          ),
                    label: 'Berkas Pengajuan',
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 1
                        ? SvgPicture.asset(
                            'assets/icons/sitemap_colored.svg',
                            height: 20,
                          )
                        : SvgPicture.asset(
                            'assets/icons/sitemap.svg',
                            height: 20,
                          ),
                    label: 'Profil Organisasi',
                  ),
                ],
                currentIndex: _selectedIndex!,
                selectedItemColor: mBlueColor,
                backgroundColor: Colors.transparent,
                selectedFontSize: 12,
                showUnselectedLabels: true,
                elevation: 0,
              ),
            ),
          );
  }
}
