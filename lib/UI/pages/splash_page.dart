import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salvapp_amcc/UI/pages/onboarding_page.dart';
import 'package:salvapp_amcc/UI/pages/sign_in_page.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../common/common.dart';
import 'holder_page.dart';

class SplashPage extends StatelessWidget {
  static const routeName = '/';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, HolderPage.routeName, (route) => false);
          }

          if (state is AuthFailed) {
            print(state.props);
            Navigator.pushNamedAndRemoveUntil(
                context, OnboardingPage.routeName, (route) => false);
          }
        },
        child: Center(
          child: Container(
            width: 182,
            height: 82,
            decoration: BoxDecoration(
                color: greenColor,
                image: DecorationImage(
                    image: AssetImage('assets/image/logowhite-png.png'))),
          ),
        ),
      ),
    );
  }
}
// @override
// void initState() {
//   super.initState();
//   Timer(
//       const Duration(seconds: 3),
//       (() => Navigator.pushNamedAndRemoveUntil(
//           context, SigninPage.routeName, (route) => false)));
// }
