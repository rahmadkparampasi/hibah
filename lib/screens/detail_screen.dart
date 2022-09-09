import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/detailo_screen.dart';
import 'package:SimhegaM/screens/detailp_screen.dart';
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
    this.selectedIndex = 0,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _selectedIndexD = 0;
  late String _token;
  String? _uslIdEx;
  String? _orgIdEx;

  bool _isLoading = false;

  String? errorMessage;

  HibahService get service => GetIt.I<HibahService>();

  Hibah? hibah;

  Organisasi? organisasi;

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
      _isLoading = true;
      _selectedIndex = widget.selectedIndex;
      options = [
        DetailPScreen(
          token: _token,
          selectedIndex: _selectedIndex,
          uslIdEx: _uslIdEx!,
        ),
      ];
    });
    if (_uslIdEx != null) {
      service.getHibah(_uslIdEx!).then((value) {
        setState(() {
          hibah = value.data;
          _orgIdEx = hibah!.uslOrg;
          _isLoading = false;

          service.getOrganisasi(hibah!.uslOrg).then((value) {
            setState(() {
              _isLoading = false;
              organisasi = value.data;
              options.add(DetailOScreen(
                token: _token,
                uslIdEx: _uslIdEx!,
                organisasi: organisasi!,
                selectedIndex: _selectedIndex,
                hibah: hibah!,
              ));
            });
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : options.elementAt(_selectedIndexD),
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
