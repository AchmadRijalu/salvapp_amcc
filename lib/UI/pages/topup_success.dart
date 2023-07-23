import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salvapp_amcc/UI/pages/home_page.dart';
import 'package:salvapp_amcc/UI/pages/sign_in_page.dart';
import 'package:salvapp_amcc/common/common.dart';

import '../widgets/buttons.dart';

class TopUpSuccessPage extends StatelessWidget {
  const TopUpSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(children: [
            Expanded(
                child: Container(
              child: LottieBuilder.asset(
                "assets/lottie/payment_success_lottie.json",
                repeat: false,
                delegates: LottieDelegates(),
                fit: BoxFit.fill,
              ),
            )),
            Expanded(
              flex: 2,
              child: Container(
                  child: Column(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Text("Pembayaran Anda Berhasil!",
                          style: Theme.of(context)!
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color: greenColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),

                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                backgroundColor: greenColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10.0)),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) {
                                return HomePage();
                              },), (route) => false);
                            },
                            child: Text("Kembali",
                                style: whiteTextStyle.copyWith(
                                    fontSize: 16, fontWeight: semiBold))),
                      )
                    ],
                  ))
                ],
              )),
            ),
          ]),
        ),
      ),
    );
  }
}
