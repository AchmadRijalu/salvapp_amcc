import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:salvapp_amcc/UI/pages/penawaran_page.dart';
import 'package:salvapp_amcc/UI/pages/profil_page.dart';

import '../../common/common.dart';
import 'beranda_page.dart';
import 'edukasi_page.dart';
import 'iklan_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePabrik';

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavbarItems = [
    
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/image/icon_iklan.svg",
        ),
        activeIcon: SvgPicture.asset(
          "assets/image/icon_iklan.svg",
          color: greenColor,
        ),
        label: "Iklan"),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/image/icon_penawaran.svg",
        ),
        activeIcon: SvgPicture.asset(
          "assets/image/icon_penawaran.svg",
          color: greenColor,
        ),
        label: "Penawaran"),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/image/icon_edukasi.svg",
        ),
        activeIcon: SvgPicture.asset(
          "assets/image/icon_edukasi.svg",
          color: greenColor,
        ),
        label: "Edukasi"),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/image/icon_profil.svg",
        ),
        activeIcon: SvgPicture.asset(
          "assets/image/icon_profil.svg",
          color: greenColor,
        ),
        label: "Profil")
  ];

  List<Widget> listWidget = [
    IklanPage(),
    PenawaranPage(),
    EdukasiPage(),
    ProfilPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listWidget[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: greenColor,
        unselectedItemColor: greyColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomNavbarItems,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle:
            greenTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
        unselectedLabelStyle:
            greenTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
        onTap: (selected) {
          setState(() {
            currentIndex = selected;
          });
        },
      ),
    );
  }
}
