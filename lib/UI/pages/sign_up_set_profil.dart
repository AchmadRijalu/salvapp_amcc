import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/shared/shared_methods.dart';
import '../../common/common.dart';
import '../../models/sign_up_form_model.dart';
import '../widgets/buttons.dart';
import 'holder_page.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SignupSetProfilPage extends StatefulWidget {
  SignupFormModel? data;
  static const routeName = '/signupsetprofil';
  SignupSetProfilPage({super.key, required this.data});

  @override
  State<SignupSetProfilPage> createState() => _SignupSetProfilPageState();
}

class _SignupSetProfilPageState extends State<SignupSetProfilPage> {
  XFile? selectedImage;
  dynamic imageStringHolder = '';

  bool validate() {
    if (selectedImage == null) {
      return false;
    }

    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: lightBackgroundColor,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is AuthFailed) {
              showCustomSnacKbar(context, state.e);
            }
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, HolderPage.routeName, (route) => false);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            }
            return SafeArea(
              child: Container(
                  child: ListView(
                children: [
                  Container(
                    color: greenColor,
                    width: double.infinity,
                    height: 167,
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Unggah foto profil anda",
                                style: whiteTextStyle.copyWith(fontSize: 20),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text(
                                "Foto profil anda memudahkan interaksi \npembeli dan penjual limbah makanan",
                                style: whiteTextStyle.copyWith(fontSize: 12),
                              )
                            ],
                          )
                        ]),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 26),
                      child: Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                            Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TimelineTile(
                                    indicatorStyle: IndicatorStyle(
                                      color: greenColor,
                                    ),
                                    afterLineStyle:
                                        LineStyle(color: greenColor),
                                    isFirst: true,
                                    axis: TimelineAxis.horizontal,
                                    alignment: TimelineAlign.center,
                                    endChild: Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      constraints: const BoxConstraints(),
                                      child: Wrap(
                                          children: [Text("Informasi Dasar", style: greenTextStyle,)]),
                                    ),
                                    startChild: Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                    ),
                                  ),
                                  TimelineTile(
                                    indicatorStyle: IndicatorStyle(
                                      color: greenColor,
                                    ),
                                    beforeLineStyle:
                                        LineStyle(color: greenColor),
                                    afterLineStyle:
                                        LineStyle(color: greenColor),
                                    axis: TimelineAxis.horizontal,
                                    alignment: TimelineAlign.center,
                                    endChild: Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      constraints: const BoxConstraints(),
                                      child: Wrap(children: [Text("Lokasi", style: greenTextStyle,)]),
                                    ),
                                    startChild: Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                    ),
                                  ),
                                  TimelineTile(
                                    indicatorStyle: IndicatorStyle(
                                      color: greyColor,
                                    ),
                                    isLast: true,
                                    axis: TimelineAxis.horizontal,
                                    alignment: TimelineAlign.center,
                                    endChild: Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      constraints: const BoxConstraints(),
                                      child:
                                          Wrap(children: [Text("Foto Profil", style: greenTextStyle,)]),
                                    ),
                                    startChild: Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Ketuk gambar awan untuk memotret atau \nmemilih foto yang anda miliki sebagai foto profil \nanda",
                                  style: greenTextStyle,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 43,
                            ),
                            Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final image = await selectImage();
                                        setState(() {
                                          selectedImage = image;
                                        });
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            color: Color(0xffF1F1F9),
                                            image: selectedImage == null
                                                ? null
                                                : DecorationImage(
                                                    image: FileImage(File(
                                                        selectedImage!.path))),
                                            shape: BoxShape.circle),
                                        child: Center(
                                            child: selectedImage != null
                                                ? null
                                                : Center(
                                                    child: SvgPicture.asset(
                                                        "assets/image/icon_upload.svg"),
                                                  )),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      widget.data!.username!,
                                      style: blackTextStyle.copyWith(
                                          fontSize: 18, fontWeight: medium),
                                    ),
                                    const SizedBox(
                                      height: 44,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 45),
                                      child: CustomFilledButton(
                                        title: "Daftar",
                                        onPressed: () {
                                          widget.data = SignupFormModel(
                                              // KecamatanId: widget.data!.KecamatanId,
                                              username: widget.data!.username,
                                              email: widget.data!.email,
                                              name: widget.data!.name,
                                              password: widget.data!.password,
                                              type: widget.data!.type,
                                              phoneNumber:
                                                  widget.data!.phoneNumber,
                                              province: widget.data!.province,
                                              city: widget.data!.city,
                                              subdistrict:
                                                  widget.data!.subdistrict,
                                              ward: widget.data!.ward,
                                              postal_code:
                                                  widget.data!.postal_code,
                                              latitude: widget.data!.latitude,
                                              longitude: widget.data!.longitude,
                                              address: widget.data!.address,
                                              image: "");

                                          context
                                              .read<AuthBloc>()
                                              .add(AuthRegister(widget.data));
                                          // print(widget.data!.username);
                                          // print(widget.data!.name);
                                          // print(widget.data!.type);
                                          // print(widget.data!.email);
                                          // print(widget.data!.address);
                                          // print(widget.data!.city);
                                          // print(widget.data!.latitude);
                                          // print(widget.data!.longitude);
                                          // print(widget.data!.password);
                                          // print(widget.data!.phoneNumber);
                                          // print(widget.data!.postal_code);
                                          // print(widget.data!.province);
                                          // print(widget.data!.subdistrict);
                                          // print(widget.data!.type);
                                          // print(widget.data!.ward);
                                          // print(widget.data!.image);
                                        },
                                      ),
                                    )
                                  ]),
                            ),
                          ]))),
                ],
              )),
            );
          },
        ));
  }
}
