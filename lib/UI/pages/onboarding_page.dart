import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:salvapp_amcc/UI/pages/sign_in_page.dart';

import '../../common/common.dart';
import '../widgets/buttons.dart';

class OnboardingPage extends StatefulWidget {
  static const routeName = '/onboarding';
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
   int currentIndex = 0;

   CarouselController carouselController = CarouselController();

  List<String> title = [
    "Salv: Solusi Limbah \nMakanan Anda!",
    "Cara Salv Bekerja",
    "Panduan Penjual",
    "Pandual Pembeli",
    "Clean the environment, \nget your benefits!"
  ];

  List<String> subTitles = [
    "Misi kami untuk mengurangi \nlimbah makanan dan mendukung \nkomunitas lokal.",
    "Tempat dimana Anda dapat \nmenjual atau membeli limbah \nmakanan sesuai kebutuhan",
    "Cari iklan dengan mudah dan \ntawarkan limbah makanan, serta \nedukasi seputar limbah makanan.",
    "Buat iklan dan terima tawaran \nlimbah makanan serta edukasi \nseputar limbah makanan.",
    "Dengan Bergabung Anda telah \nmendukung misi kami, bagikan \npengalaman, dan bertukar ide."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
              carouselController: carouselController,
              items: [
                Image.asset(
                  "assets/image/image_onboarding1.png",
                  height: 331,
                ),
                Image.asset(
                  "assets/image/image_onboarding1.png",
                  height: 331,
                ),
                Image.asset(
                  "assets/image/image_onboarding1.png",
                  height: 331,
                ),
                Image.asset(
                  "assets/image/image_onboarding2.png",
                  height: 331,
                ),
                Image.asset(
                  "assets/image/image_onboarding3.png",
                  height: 331,
                ),
              ],
              options: CarouselOptions(
                  height: 331,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: ((index, reason) {
                    setState(() {
                      currentIndex = index;
                      print(currentIndex);
                    });
                  }))),
          const SizedBox(
            height: 80,
          ),
          Container(
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
            child: Column(children: [
              Text(
                "${title[currentIndex]}",
                textAlign: TextAlign.center,
                style:
                    blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "${subTitles[currentIndex]}",
                style: greyTextStyle.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: currentIndex == 4 ? 38 : 50,
              ),
              // currentIndex == 4
              //     ? Column(
              //         children: [
              //           CustomFilledButton(
              //             title: "Get Started",
              //             onPressed: () {
              //               Navigator.pushNamedAndRemoveUntil(
              //                   context, "/sign-up", (route) => false);
              //             },
              //           ),
              //           SizedBox(
              //             height: 20,
              //           ),
              //           CustomTextButton(
              //             title: "Sign In",
              //             onPressed: () {
              //               Navigator.pushNamedAndRemoveUntil(
              //                   context, "/sign-in", (route) => false);
              //             },
              //           )
              //         ],
              //       )
              // :
                  Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 0
                                  ? greenColor
                                  : lightBackgroundColor),
                        ),
                        Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 1
                                  ? greenColor
                                  : lightBackgroundColor),
                        ),
                        Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 2
                                  ? blueColor
                                  : lightBackgroundColor),
                        ),
                        Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 3
                                  ? greenColor
                                  : lightBackgroundColor),
                        ),
                        Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 4
                                  ? greenColor
                                  : lightBackgroundColor),
                        ),
                        const Spacer(),
                        currentIndex == 4?
                        CustomFilledButton(
                          width: 150,
                          title: "Mulai",
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, SigninPage.routeName, (route) => false);
                          },
                        ):
                        CustomFilledButton(
                          width: 150,
                          title: "Lanjut",
                          onPressed: () {
                            carouselController.nextPage();
                          },
                        )
                      ],
                    )
            ]),
          )
        ],
      )),
    );
  }
}