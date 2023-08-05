import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salvapp_amcc/UI/pages/onboarding_page.dart';
import 'package:salvapp_amcc/UI/pages/topup_amount_page.dart';
import 'package:salvapp_amcc/UI/pages/webview_midtrans_page.dart';

import 'UI/pages/beranda_detail.dart';
import 'UI/pages/beranda_page.dart';
import 'UI/pages/camera_preview_page.dart';
import 'UI/pages/detail_edukasi_page.dart';
import 'UI/pages/detail_iklan_page.dart';
import 'UI/pages/detail_penawaran_page.dart';
import 'UI/pages/edukasi_page.dart';
import 'UI/pages/form_jual_limbah_page.dart';
import 'UI/pages/holder_page.dart';
import 'UI/pages/iklan_page.dart';
import 'UI/pages/jual_limbah_success_page.dart';
import 'UI/pages/penawaran_page.dart';
import 'UI/pages/pencairan_poin_page.dart';
import 'UI/pages/profil_page.dart';
import 'UI/pages/sign_in_page.dart';
import 'UI/pages/sign_up_page.dart';
import 'UI/pages/sign_up_success_page.dart';
import 'UI/pages/splash_page.dart';
import 'UI/pages/tambah_iklan_limbah1_page.dart';
import 'UI/pages/tambah_iklan_limbah2_page.dart';
import 'UI/pages/tambah_iklan_limbah3_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'UI/pages/ubah_data_alamat_page.dart';
import 'UI/pages/ubah_data_profil_page.dart';
import 'blocs/auth/auth_bloc.dart';

import 'package:firebase_core/firebase_core.dart';

import 'blocs/edukasi/edukasi_bloc.dart';
import 'common/common.dart';
import 'models/topup_form_model.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc()..add(AuthGetCurrentUser())),
        BlocProvider(create: (context) => EdukasiBloc()..add(EdukasiGetAll())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Salv',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: lightBackgroundColor,
            appBarTheme: AppBarTheme(
                elevation: 0,
                backgroundColor: lightBackgroundColor,
                centerTitle: true,
                titleTextStyle: blackTextStyle.copyWith(
                    color: blackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                iconTheme: IconThemeData(color: blackColor))),
        routes: {
          SplashPage.routeName: (context) => SplashPage(),
          HolderPage.routeName: (context) => HolderPage(),
          BerandaPage.routeName: (context) => BerandaPage(),
          EdukasiPage.routeName: (context) => EdukasiPage(),
          IklanPage.routeName: (context) => IklanPage(),
          PenawaranPage.routeName: (context) => PenawaranPage(),
          ProfilPage.routeName: (context) => ProfilPage(),
          SigninPage.routeName: (context) => SigninPage(),
          SignupPage.routeName: (context) => SignupPage(),
          SignupSuccessPage.routeName: (context) => SignupSuccessPage(),
          DetailIklanPage.routeName: (context) => DetailIklanPage(),
          FormJualLimbahPage.routeName: (context) => FormJualLimbahPage(),
          JualLimbahSuccessPage.routeName: (context) => JualLimbahSuccessPage(),
          DetailPenawaranPage.routeName: (context) => DetailPenawaranPage(),
          DetailEdukasiPage.routeName: (context) => DetailEdukasiPage(),
          PencairanPoinPage.routeName: (context) => PencairanPoinPage(
                point: ModalRoute.of(context)!.settings.arguments as int,
              ),
          UbahDataProfilPage.routeName: (context) => UbahDataProfilPage(),
          UbahDataAlamatPage.routeName: (context) => UbahDataAlamatPage(),
          BerandaDetailPage.routeName: (context) => BerandaDetailPage(),
          TambahIklanLimbah1Page.routeName: (context) => TambahIklanLimbah1Page(
                step: ModalRoute.of(context)!.settings.arguments as int,
              ),
          CameraPreviewPage.routeName: (context) =>
              CameraPreviewPage(picture: '', label: ''),
          TopupAmountPage.routeName: (context) => TopupAmountPage(),
          WebviewMidtransPage.routeName: (context) => WebviewMidtransPage(
              topupFormModel:
                  ModalRoute.of(context)!.settings.arguments as TopupFormModel),
          OnboardingPage.routeName: (context) => OnboardingPage(),
        },
      ),
    );
  }
}
