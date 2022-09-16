import 'package:SimhegaM/services/hibah_services.dart';
import 'package:SimhegaM/services/hibahcomp_services.dart';
import 'package:SimhegaM/services/hibahstj_services.dart';
import 'package:flutter/material.dart';
import 'package:SimhegaM/screens/splash_screen.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => HibahService());
  GetIt.I.registerLazySingleton(() => HibahStjService());
  GetIt.I.registerLazySingleton(() => HibahCompService());
}

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIMPEGPLUS',
      home: SplashScreen(),
    );
  }
}
