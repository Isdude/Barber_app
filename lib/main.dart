import 'package:barber_app/pages/checkout_page.dart';
import 'package:barber_app/pages/get_started_page.dart';
import 'package:barber_app/pages/home_page.dart';
import 'package:barber_app/pages/layanan_item_page.dart';
import 'package:barber_app/pages/pegawai_page.dart';
import 'package:barber_app/pages/pelanggan_page.dart';
import 'package:barber_app/pages/pilih_layanan_item_page.dart';
import 'package:barber_app/pages/pilih_pelanggan_page.dart';
import 'package:barber_app/pages/signup_page.dart';
import 'package:barber_app/pages/splash_screen_page.dart';
import 'package:barber_app/pages/transaksi_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'firebase_options.dart';
import 'pages/login_page.dart';
import 'pages/transaksi_selesai_page.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}