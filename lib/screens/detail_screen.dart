import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/detailo_screen.dart';
import 'package:SimhegaM/screens/detailp_screen.dart';
import 'package:SimhegaM/screens/home_screen.dart';
import 'package:SimhegaM/screens/items/comp_items.dart';
import 'package:SimhegaM/screens/items/func_item.dart';
import 'package:SimhegaM/screens/masuk_screen.dart';
import 'package:SimhegaM/services/hibah_services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

class DetailScreen extends StatefulWidget {
  final String token;
  final String pgnJns;
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final int selectedIndexD;

  const DetailScreen({
    super.key,
    required this.token,
    required this.pgnJns,
    required this.uslIdEx,
    required this.orgIdEx,
    this.selectedIndex = 0,
    this.selectedIndexD = 0,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _selectedIndexD = 0;
  late String _token;
  late String _pgnJns;
  String? _uslIdEx;
  String? _orgIdEx;

  Hibah? hibah;

  HibahService get service => GetIt.I<HibahService>();

  String? errorMessage;
  bool _isError = false;
  bool _isLoading = false;

  late int _selectedIndex;

  late var options = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndexD = index;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
      _token = widget.token;
      _pgnJns = widget.pgnJns;
      _uslIdEx = widget.uslIdEx;
      _orgIdEx = widget.orgIdEx;

      _selectedIndex = widget.selectedIndex;
      options = [
        DetailPScreen(
          token: _token,
          selectedIndex: _selectedIndex,
          uslIdEx: _uslIdEx!,
          selectedIndexD: widget.selectedIndexD,
          pgnJns: _pgnJns,
        ),
        DetailOScreen(
          token: _token,
          selectedIndex: _selectedIndex,
          orgIdEx: _orgIdEx!,
        )
      ];
    });
    if (_uslIdEx != null) {
      service.getHibah(_uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;

          if (hibah == null) {
            _isError = true;
          } else {
            _isError = false;
          }
          if (value.error) {
            _isLoading = false;
            errorMessage = value.errorMessage!;
          } else {
            _isLoading = false;
          }
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.grey,
                ),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      selectedIndex: _selectedIndex,
                      token: _token,
                      changeOptions: 0,
                      pgnJns: _pgnJns,
                    ),
                  ),
                ),
              ),
              const Text(
                'Usulan',
                style: TextStyle(
                  fontSize: 14.5,
                  letterSpacing: 0.15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          hibah == null
              ? const Padding(
                  padding: EdgeInsets.only(right: 20.0),
                )
              : hibah!.uslSls != ''
                  ? hibah!.uslSls != "0" ||
                          hibah!.uslSls != "1" ||
                          hibah!.uslSls != "2" ||
                          hibah!.uslSls != "3"
                      ? Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: GestureDetector(
                            onTap: () async {
                              _pgnJns == ''
                                  ? false
                                  : showBottomModal(
                                      context,
                                      _pgnJns == 'VER'
                                          ? CompBottomVerCtk(
                                              uslIdEx: hibah!.uslIdEx,
                                              orgIdEx: hibah!.uslOrg,
                                              selectedIndex:
                                                  widget.selectedIndexD,
                                              token: widget.token,
                                              pgnJns: widget.pgnJns,
                                            )
                                          : _pgnJns == 'CR'
                                              ? CompBottomCairCtk(
                                                  uslIdEx: hibah!.uslIdEx,
                                                  orgIdEx: hibah!.uslOrg,
                                                  selectedIndex:
                                                      widget.selectedIndexD,
                                                  token: widget.token,
                                                  pgnJns: widget.pgnJns,
                                                )
                                              : const Center(
                                                  child: Text(
                                                    'Tidak Ada Data Untuk Dicetak',
                                                  ),
                                                ),
                                      _pgnJns == 'VER' ? 300 : 350,
                                    );
                            },
                            child: const Icon(
                              Icons.print_outlined,
                              size: 26.0,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                        )
                  : const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                    ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => showBottomModal(
                  context,
                  CompBottomSrt(
                    uslIdEx: _uslIdEx!,
                    orgIdEx: widget.orgIdEx,
                    selectedIndex: _selectedIndex,
                    token: _token,
                    pgnJns: _pgnJns,
                  ),
                  500),
              child: const Icon(
                Icons.mail_outline,
                size: 26.0,
                color: Colors.blue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.QUESTION,
                  title: 'Maaf',
                  desc: 'Apakah Ingin Keluar Dari Aplikasi',
                  btnOkOnPress: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MasukScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  btnCancelOnPress: () {},
                ).show();
              },
              child: const Icon(
                Icons.power_settings_new_rounded,
                size: 26.0,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: options.elementAt(_selectedIndexD),
      bottomNavigationBar: Container(
        height: 80,
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
              icon: _selectedIndexD == 0
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
              icon: _selectedIndexD == 1
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
          currentIndex: _selectedIndexD,
          selectedItemColor: mBlueColor,
          backgroundColor: Colors.transparent,
          selectedFontSize: 12,
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          elevation: 0,
        ),
      ),
    );
  }
}
