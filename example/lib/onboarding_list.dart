import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_splash_boarding/modules/onboarding/model/onboarding_model.dart';
import 'package:max_splash_boarding/modules/onboarding/onboarding_screen.dart';

class MomentList extends StatefulWidget {
  const MomentList({super.key});

  @override
  State<MomentList> createState() => _MomentListState();
}

Map<String, dynamic> params = {};

class _MomentListState extends State<MomentList> {
  @override
  Widget build(BuildContext context) {
    return MaxBoarding(
      boarding: boarding,
      textToast: 'tes',
      onRoute: () {},
      texButton: 'Selanjutnya',
    );
  }

  final List<OnboardingData> boarding = [
    OnboardingData(
      title: "Management Restoran",
      description:
          "Kelola restoranmu dan tingkatkan penjualan dengan berbagai fitur lengkap di Orderia Merchant.",
      images: "assets/onboarding/ilustration_onboarding_1.png",
    ),
    OnboardingData(
      title: "Kalender Reservasi",
      description:
          "Orderia membantu Anda menangani reservasi 24 jam sehari, 7 hari seminggu. Dan pantau jadwal reservasi dengan mudah.",
      images: "assets/onboarding/ilustration_onboarding_2.png",
    ),
    OnboardingData(
      title: "Datangkan Pelanggan",
      description:
          "Dapatkan akses ke pelanggan baru yang tak terhitung jumlahnya dengan memberikan pelayanan terbaik.",
      images: "assets/onboarding/ilustration_onboarding_3.png",
    ),
  ];
}
