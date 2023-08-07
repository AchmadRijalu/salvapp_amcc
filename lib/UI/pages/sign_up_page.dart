import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:salvapp_amcc/UI/pages/sign_up_set_profil.dart';
import 'package:salvapp_amcc/UI/pages/sign_up_wilayah_page.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../blocs/shared/shared_methods.dart';
import '../../common/common.dart';
import '../../models/sign_up_form_model.dart';
import '../widgets/buttons.dart';
import '../widgets/forms.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup';
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupFormModel? data;
  List<String> listTipe = ["buyer", "seller"];
  final TextEditingController nomorteleponController =
      TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController usernameController =
      TextEditingController(text: '');
  final TextEditingController katasandiController =
      TextEditingController(text: '');
  final TextEditingController namaLengkapController =
      TextEditingController(text: '');

  final _keyState = GlobalKey<FormState>();

  bool _obscureText = true;

  dynamic tipe;

  bool validate() {
    if (nomorteleponController.text.isEmpty ||
        emailController.text.isEmpty ||
        namaLengkapController.text.isEmpty ||
        usernameController.text.isEmpty ||
        katasandiController.text.isEmpty ||
        tipe == null) {
      return false;
    }

    // Validate the email format
    if (!isValidEmail(emailController.text)) {
      return false;
    }

    return true;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  void initState() {
    // TODO: implement initState
    _obscureText = true;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nomorteleponController.dispose();
    usernameController.dispose();
    katasandiController.dispose();
    namaLengkapController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Daftar")),
      body: Container(
        child: ListView(
            physics: BouncingScrollPhysics(),
            reverse: false,
            children: [
              Container(
                color: greenColor,
                width: double.infinity,
                height: 227,
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Masukkan nama pengguna, \nkata sandi dan nomor \ntelepon yang akan dipakai.",
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
                            "Daftar terlebih dahulu agar dapat menikmati \nfitur-fitur tambahan aplikasi ini",
                            style: whiteTextStyle.copyWith(fontSize: 12),
                          )
                        ],
                      )
                    ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
                child: Container(
                    child: Column(
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
                            isFirst: true,
                            axis: TimelineAxis.horizontal,
                            alignment: TimelineAlign.center,
                            endChild: Container(
                              margin: const EdgeInsets.only(top: 14),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.5,
                              constraints: const BoxConstraints(),
                              child: Wrap(children: [
                                Text(
                                  "Informasi Dasar",
                                  style: greenTextStyle,
                                )
                              ]),
                            ),
                            startChild: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
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
                              width: MediaQuery.of(context).size.width / 2.5,
                              constraints: const BoxConstraints(),
                              child: Wrap(children: [
                                Text(
                                  "Foto Profil",
                                  style: greenTextStyle,
                                )
                              ]),
                            ),
                            startChild: Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 44,
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(children: [
                        CustomFormField(
                          isShowTitle: false,
                          title: "Nama Lengkap",
                          controller: namaLengkapController,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        CustomFormField(
                          isShowTitle: false,
                          title: "Username",
                          controller: usernameController,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular, fontSize: 14),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              //PASSWORD
                              TextFormField(
                                cursorColor: greenColor,
                                validator: (val) =>
                                    val!.isEmpty || !val.contains("@")
                                        ? "Masukkan format email yang benar"
                                        : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: emailController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: greenColor, width: 2.0),
                                    ),
                                    hintText: "Masukkan Email",
                                    contentPadding: const EdgeInsets.all(12),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        CustomFormField(
                          isShowTitle: false,
                          controller: nomorteleponController,
                          title: "Nomor Telepon",
                          keyBoardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Kata Sandi",
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular, fontSize: 14),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              //PASSWORD
                              TextFormField(
                                cursorColor: greenColor,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: katasandiController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                    hintText: "Masukkan Kata Sandi",
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: greenColor, width: 2.0),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: _obscureText
                                          ? Icon(
                                              Icons.visibility_off,
                                              color: greenColor,
                                            )
                                          : Icon(
                                              Icons.visibility,
                                              color: greenColor,
                                            ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                    contentPadding: const EdgeInsets.all(12),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            Text(
                              "Tipe",
                              style: blackTextStyle.copyWith(
                                  fontWeight: regular, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: greenColor, width: 2.0),
                              ),
                              hintText: "Pilih Tipe",
                              focusColor: greenColor,
                              contentPadding: const EdgeInsets.all(12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          items: listTipe.map((dynamic val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              tipe = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        CustomFilledButton(
                          title: "Selanjutnya",
                          onPressed: () {
                            if (validate()) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return SignupSetProfilPage(
                                      data: SignupFormModel(
                                          username: usernameController.text,
                                          email: emailController.text,
                                          name: namaLengkapController.text,
                                          password: katasandiController.text,
                                          type: tipe == "buyer" ? 2 : 3,
                                          phoneNumber:
                                              nomorteleponController.text));
                                },
                              ));
                            } else {
                              showCustomSnacKbar(context,
                                  "Form tidak boleh kosong dan harus sesuai format");
                            }
                            // Navigator.pushNamed(context, SignupWilayahPage.routeName);
                          },
                        ),
                        const SizedBox(
                          height: 17,
                        )
                      ]),
                    ),
                    const SizedBox(
                      height: 12,
                    )
                  ],
                )),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom))
            ]),
      ),
    );
  }
}
