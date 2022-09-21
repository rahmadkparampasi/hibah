import 'package:SimhegaM/constants/style_constant.dart';
import 'package:SimhegaM/screens/proses_screen.dart';
import 'package:SimhegaM/screens/selesai_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  final int changeOptions;

  final String token;
  final String pgnJns;
  final int selectedIndex = 0;
  const HomeScreen({
    this.changeOptions = 0,
    required this.token,
    required this.pgnJns,
    required int selectedIndex,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedIndex;
  late String _token;
  late String _pgnJns;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late var options = [];

  bool isAscending = false;
  int? sortColumnIndex;

  @override
  void initState() {
    super.initState();
    setState(() {
      _token = widget.token;
      _pgnJns = widget.pgnJns;
      _selectedIndex = widget.selectedIndex;
      options = [
        ProsesScreen(
          token: _token,
          selectedIndex: _selectedIndex!,
          pgnJns: _pgnJns,
        ),
        SelesaiScreen(
          token: _token,
          selectedIndex: _selectedIndex!,
          pgnJns: _pgnJns,
        ),
      ];
    });
    if (widget.changeOptions != 0) {
      setState(() {
        _selectedIndex = widget.changeOptions;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
                icon: _selectedIndex == 0
                    ? SvgPicture.asset(
                        'assets/icons/sync_colored.svg',
                        height: 20,
                      )
                    : SvgPicture.asset(
                        'assets/icons/sync.svg',
                        height: 20,
                      ),
                label: 'Sementara Proses',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 1
                    ? SvgPicture.asset(
                        'assets/icons/check_colored.svg',
                        height: 20,
                      )
                    : SvgPicture.asset(
                        'assets/icons/check.svg',
                        height: 20,
                      ),
                label: 'Telah Selesai',
              ),
            ],
            currentIndex: _selectedIndex!,
            selectedItemColor: mBlueColor,
            onTap: _onItemTapped,
            backgroundColor: Colors.transparent,
            selectedFontSize: 12,
            showUnselectedLabels: true,
            elevation: 0,
          ),
        ),
        body: Row(
          children: <Widget>[
            Expanded(child: options.elementAt(_selectedIndex!)),
          ],
        ),
      );
}
