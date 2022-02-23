import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:hbh/views/akun.dart';
import 'package:hbh/views/home.dart';
import 'package:hbh/views/pro.dart';
import 'package:hbh/views/ver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Image.asset(
              'assets/images/logo.png',
              height: 120,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'SI-MEHGA SULTENG',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            // CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            // )
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TabController tabControllerr;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // APP BAR
        appBar: AppBar(
            backgroundColor: Colors.indigoAccent[700],
            // flexibleSpace: Image(
            //   image: AssetImage('assets/images/logo.png'),
            //   fit: BoxFit.fill,
            // ),

            title: Text(
              "SI-MEHGA",
            ),

            //baru ditambahkan
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  print("Diklik");
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {
                  print("Diklik");
                },
              ),
            ]

            //batas
            ),

        // BODY
        body: TabBarView(
          children: <Widget>[
            home(),
            pro(),
            ver(),
            // akun(),
          ],
        ),

        //Navigasi Bawah
        bottomNavigationBar: TabBar(
          labelColor: Colors.indigoAccent[700],
          labelStyle: TextStyle(
            fontSize: 14,
          ),
          unselectedLabelColor: Colors.grey,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(style: BorderStyle.none)),
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home),
              text: "Home",
            ),
            Tab(
              icon: Icon(Icons.feed),
              text: "Proposal",
            ),
            Tab(
              icon: Icon(Icons.check_rounded),
              text: "Verifikasi",
            ),
            // Tab(
            //   icon: Icon(Icons.account_circle),
            //   text: "Akun",
            // ),
          ],
        ),
      ),
    );
  }
}
