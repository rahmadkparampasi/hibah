import 'package:SimhegaM/models/api_response.dart';
import 'package:SimhegaM/models/hibah_model.dart';
import 'package:SimhegaM/screens/items/func_item.dart';
import 'package:SimhegaM/screens/items/comp_items.dart';
import 'package:SimhegaM/screens/items/sp_icon.dart';
import 'package:SimhegaM/screens/list/prop_list.dart';
import 'package:SimhegaM/screens/list/usla_list.dart';
import 'package:SimhegaM/screens/list/uslba_list.dart';
import 'package:SimhegaM/screens/list/uslbrks_list.dart';
import 'package:SimhegaM/screens/list/uslgmbr_list.dart';
import 'package:SimhegaM/screens/list/uslinb_list.dart';
import 'package:SimhegaM/screens/list/uslthp_list.dart';
import 'package:SimhegaM/screens/list/uslver_list.dart';
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

class _DetailPScreenState extends State<DetailPScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  late String _token;
  String? _uslIdEx;

  bool _isLoading = false;

  String? errorMessage;

  HibahService get service => GetIt.I<HibahService>();

  Hibah? hibah;

  int? _selectedIndex;

  int? _selectedIndexD;

  List<Widget> listTab = const [
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
  ];

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

    _controller = TabController(length: listTab.length, vsync: this);

    _controller?.addListener(() {
      setState(() {
        _selectedIndexD = _controller!.index;
      });
    });
  }

  _fetchhibah(String uslIdEx) async {
    await service.getHibah(uslIdEx).then((value) {
      setState(() {
        hibah = value.data;
      });
    });
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
                                  RichText(
                                    text: const TextSpan(
                                      text: 'BERKAS PENGUSULAN',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
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
                              hibah == null ? 'Belum Ada Judul' : hibah!.uslNm,
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
                                  onTap: (selectedIndexD) {
                                    switch (selectedIndexD) {
                                      case 0:
                                        {
                                          _fetchhibah(_uslIdEx!);
                                        }
                                        break;
                                      case 1:
                                        {}
                                        break;
                                      case 2:
                                        {}
                                        break;
                                      case 3:
                                        {}
                                        break;
                                      case 4:
                                        {}
                                        break;
                                      case 5:
                                        {}
                                        break;
                                      case 6:
                                        {}
                                        break;
                                    }
                                  },
                                  controller: _controller,
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
                                  tabs: listTab,
                                ),
                              ),
                              Container(
                                height: height * 0.5,
                                child: TabBarView(
                                  controller: _controller,
                                  children: <Widget>[
                                    PropList(
                                      uslLb: hibah == null
                                          ? 'Belum Ada Latar Belakang'
                                          : hibah!.uslLb,
                                      uslTtp: hibah == null
                                          ? 'Belum Ada Penutup'
                                          : hibah!.uslTtp,
                                      uslIdEx: _uslIdEx!,
                                    ),
                                    ListView(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        _uslIdEx == null
                                            ? Column(
                                                children: const <Widget>[
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Belum Ada Berkas',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : UslBrksList(uslIdEx: _uslIdEx!),
                                      ],
                                    ),
                                    _uslIdEx == null
                                        ? Column(
                                            children: const <Widget>[
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Belum Ada Anggaran Yang Diusulkan',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          )
                                        : UslAList(uslIdEx: _uslIdEx!),
                                    ListView(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        _uslIdEx == null
                                            ? Column(
                                                children: const <Widget>[
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Belum Ada Dokumentasi Lapangan',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : UslThpList(uslIdEx: _uslIdEx!),
                                      ],
                                    ),
                                    ListView(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: const Center(
                                            child: Text(
                                              'Dokumentasi Lapangan',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ),
                                        _uslIdEx == null
                                            ? Column(
                                                children: const <Widget>[
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Belum Ada Dokumentasi Lapangan',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : UslGmbrList(
                                                uslIdEx: _uslIdEx!,
                                              ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Divider(),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: const Center(
                                            child: Text(
                                              'Berita Acara',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ),
                                        _uslIdEx == null
                                            ? Column(
                                                children: const <Widget>[
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Belum Ada Berita Acara',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : UslBaList(uslIdEx: _uslIdEx!),
                                      ],
                                    ),
                                    ListView(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: const Center(
                                            child: Text(
                                              'Anggota Verifikator',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ),
                                        _uslIdEx == null
                                            ? Column(
                                                children: const <Widget>[
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Belum Ada Anggota Verifikator',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : UslVerList(
                                                uslIdEx: _uslIdEx!,
                                              ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                    ListView(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: const Center(
                                            child: Text(
                                              'Surat Pemberitahuan',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ),
                                        _uslIdEx == null
                                            ? Column(
                                                children: const <Widget>[
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Belum Ada Surat Pemberitahuan',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : UslInbList(
                                                uslIdEx: _uslIdEx!,
                                              ),
                                        const SizedBox(
                                          height: 5,
                                        ),
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
                    height: 8,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: ListTile(
                            onTap: () => showBottomModal(
                                context,
                                CompBottomUslT(
                                  uslIdEx: _uslIdEx!,
                                  orgIdEx: hibah!.uslOrg,
                                  selectedIndex: _selectedIndex!,
                                  token: _token!,
                                ),
                                200),
                            minLeadingWidth: 0,
                            leading: const SizedBox(
                              height: double.infinity,
                              child: SPIcon(assetName: 'prize.png'),
                            ),
                            title: const Text(
                              'Jenis Bantuan',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            subtitle: Text(
                              hibah == null
                                  ? 'Belum Ditentukan'
                                  : hibah!.uslT == "0"
                                      ? 'Belum Ditentukan'
                                      : hibah!.uslT == "1"
                                          ? 'Bantuan Uang ${hibah!.uslThn}'
                                          : 'Bantuan Barang ${hibah!.uslThn}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: const SizedBox(
                              height: double.infinity,
                              child: SPIcon(
                                width: 15,
                                height: 15,
                                assetName: 'sync.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
