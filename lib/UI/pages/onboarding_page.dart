import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
    "Grow Your\nFinancial Today",
    "Build From\nZero to Freedom",
    "Start Together"
  ];

  List<String> subTitles = [
    "Our system is helping you to\nachieve a better goal",
    "We provide tips for you so that\nyou can adapt easier",
    "We will guide you to where\nyou wanted it too"
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
                // Image.asset(
                //   "assets/img_onboarding1.png",
                //   height: 331,
                // ),
                // Image.asset(
                //   "assets/img_onboarding2.png",
                //   height: 331,
                // ),
                // Image.asset(
                //   "assets/img_onboarding3.png",
                //   height: 331,
                // ),
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
                height: currentIndex == 2 ? 38 : 50,
              ),
              currentIndex == 2
                  ? Column(
                      children: [
                        CustomFilledButton(
                          title: "Get Started",
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/sign-up", (route) => false);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextButton(
                          title: "Sign In",
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/sign-in", (route) => false);
                          },
                        )
                      ],
                    )
                  : Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 0
                                  ? blueColor
                                  : lightBackgroundColor),
                        ),
                        Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == 1
                                  ? blueColor
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
                        const Spacer(),
                        CustomFilledButton(
                          width: 150,
                          title: "Continue",
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