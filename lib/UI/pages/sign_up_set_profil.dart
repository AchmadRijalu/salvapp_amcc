import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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
  String downloadUrl = "";

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text("Daftar")),
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
                    height: 149,
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
                                          2.5,
                                      constraints: const BoxConstraints(),
                                      child: Wrap(children: [
                                        Text(
                                          "Informasi Dasar",
                                          style: greenTextStyle,
                                        )
                                      ]),
                                    ),
                                    startChild: Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
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
                                          2.5,
                                      constraints: const BoxConstraints(),
                                      child: Wrap(children: [
                                        Text(
                                          "Foto Profil",
                                          style: greenTextStyle,
                                        )
                                      ]),
                                    ),
                                    startChild: Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
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
                                        onPressed: () async {
                                          Future.delayed(Duration(seconds: 1),
                                              () async {
                                            final storageRef =
                                                FirebaseStorage.instance.ref();
                                            final pictureRef = storageRef
                                                .child(selectedImage!.path);
                                            String dataUrl =
                                                'data:image/png;base64,' +
                                                    base64Encode(File(
                                                            selectedImage!.path)
                                                        .readAsBytesSync());

                                            //Getting reference to storage root
                                            Reference reference =
                                                FirebaseStorage.instance.ref();
                                            Reference referenceDirectoryImages =
                                                reference.child('image');
                                            //Store the file
                                            if (selectedImage != null) {
                                              try {
                                                await pictureRef.putString(
                                                    dataUrl,
                                                    format: PutStringFormat
                                                        .dataUrl);
                                                downloadUrl = await pictureRef
                                                    .getDownloadURL();
                                              } catch (e) {
                                                //Nothing yet
                                              }
                                            }
                                            widget.data = SignupFormModel(
                                                username: widget.data!.username,
                                                email: widget.data!.email,
                                                name: widget.data!.name,
                                                password: widget.data!.password,
                                                type: widget.data!.type,
                                                phoneNumber:
                                                    widget.data!.phoneNumber,
                                                image: downloadUrl);
                                            context
                                                .read<AuthBloc>()
                                                .add(AuthRegister(widget.data));
                                          });
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
