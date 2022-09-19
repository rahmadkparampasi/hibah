import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/screens/detailo_screen.dart';
import 'package:SimhegaM/screens/detailp_screen.dart';
import 'package:SimhegaM/screens/home_screen.dart';
import 'package:SimhegaM/screens/items/comp_items.dart';
import 'package:SimhegaM/screens/items/func_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailScreen extends StatefulWidget {
  final String token;
  final String uslIdEx;
  final String orgIdEx;
  final int selectedIndex;
  final int selectedIndexD;

  const DetailScreen({
    required this.token,
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
  String? _uslIdEx;
  String? _orgIdEx;

  String? errorMessage;

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
      _token = widget.token;
      _uslIdEx = widget.uslIdEx;
      _orgIdEx = widget.orgIdEx;

      _selectedIndex = widget.selectedIndex;
      options = [
        DetailPScreen(
          token: _token,
          selectedIndex: _selectedIndex,
          uslIdEx: _uslIdEx!,
          selectedIndexD: widget.selectedIndexD,
        ),
        DetailOScreen(
          token: _token,
          selectedIndex: _selectedIndex,
          orgIdEx: _orgIdEx!,
        )
      ];
    });
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
                  ),
                  400),
              child: const Icon(
                Icons.mail_outline,
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
