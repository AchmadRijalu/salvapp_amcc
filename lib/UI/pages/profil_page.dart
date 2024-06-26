import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salvapp_amcc/UI/pages/pencairan_poin_page.dart';
import 'package:salvapp_amcc/UI/pages/sign_in_page.dart';
import 'package:salvapp_amcc/UI/pages/topup_amount_page.dart';

import 'package:salvapp_amcc/UI/pages/ubah_data_alamat_page.dart';
import 'package:salvapp_amcc/UI/pages/ubah_data_profil_page.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/shared/shared_methods.dart';
import '../../common/common.dart';
import '../widgets/profil_menu_widget.dart';

class ProfilPage extends StatelessWidget {
  static const routeName = '/profil';
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener

            if (state is AuthFailed) {
              showCustomSnacKbar(context, state.e);
            }

            if (state is AuthInitial) {
              Navigator.pushNamedAndRemoveUntil(
                  context, SigninPage.routeName, (route) => false);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(color: greenColor),
              );
            }

            if (state is AuthSuccess) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  child: ListView(children: [
                    const SizedBox(
                      height: 36,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Profil",
                          style: blueTextStyle.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 22),
                      child: Column(children: [
                        //  Image.memory(base64.decode(state.user!.image.split(',').last)),

                        state.user!.image == ""
                            ? Container(
                                width: 120,
                                height: 120,
                                child: CircleAvatar(
                                    backgroundColor: whiteColor,
                                    radius: 50, // Image radius
                                    backgroundImage: AssetImage(
                                        "assets/image/user_no_profpic.png")))
                            : Container(
                                width: 120,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: whiteColor,
                                  child: ClipOval(
                                    child: FadeInImage(
                                      placeholder: AssetImage(
                                          "assets/image/user_no_profpic.png"),
                                      image: NetworkImage(state.user!.image ??
                                          "assets/image/user_pic.png"),
                                      fadeInDuration: Duration(
                                          milliseconds:
                                              300), // Set your desired duration
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Halo, ${state.user!.username!}",
                              style: blackTextStyle.copyWith(
                                  fontSize: 20, fontWeight: bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PencairanPoinPage.routeName,
                                arguments: state.user!.point);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Poin: Rp.${state.user!.point!}",
                                style: blackTextStyle.copyWith(
                                    fontSize: 18, fontWeight: medium),
                              ),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ProfileMenu(
                          iconUrl: "assets/image/icon_profil.svg",
                          title: "Ubah Data Profil",
                          ontap: () {
                            Navigator.pushNamed(
                                context, UbahDataProfilPage.routeName);
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, TopupAmountPage.routeName);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: Row(children: [
                              Icon(Icons.wallet),
                              const SizedBox(
                                width: 18,
                              ),
                              Text(
                                "Topup",
                                style: blackTextStyle.copyWith(
                                    fontSize: 14, fontWeight: medium),
                              )
                            ]),
                          ),
                        ),
                        ProfileMenu(
                          iconUrl: "assets/image/icon_location.svg",
                          title: "Ubah Data Alamat",
                          ontap: () {
                            Navigator.pushNamed(
                                context, UbahDataAlamatPage.routeName);
                          },
                        ),

                        ProfileMenu(
                          iconUrl: "assets/image/icon_logout.svg",
                          title: "Logout",
                          ontap: () {
                            context.read<AuthBloc>().add(AuthLogout());
                            // Navigator.pushNamedAndRemoveUntil(
                            //     context, SigninPage.routeName, (route) => false);
                          },
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 87,
                    ),
                  ]),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
