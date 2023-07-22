import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salvapp_amcc/UI/pages/sign_up_page.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/shared/shared_methods.dart';
import '../../common/common.dart';
import '../../models/sign_in_form_model.dart';
import '../../models/user_model.dart';
import '../widgets/buttons.dart';
import '../widgets/forms.dart';
import 'holder_page.dart';

class SigninPage extends StatefulWidget {
  static const routeName = '/signin';
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController usernameController =
      TextEditingController(text: '');
  final TextEditingController katasandiController =
      TextEditingController(text: '');

  bool _obscureText = true;
  bool validate() {
    if (usernameController.text.isEmpty || katasandiController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void initState() {
    // TODO: implement initState
    _obscureText = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                child: Column(children: [
              Flexible(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Masuk",
                            style: whiteTextStyle.copyWith(
                                color: whiteColor,
                                fontSize: 20,
                                fontWeight: regular),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            "Masuk dengan email \natau username dan kata sandi anda.",
                            style: whiteTextStyle.copyWith(
                                color: whiteColor, fontSize: 12),
                          )
                        ],
                      )
                    ]),
                color: greenColor,
              )),
              Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 23, horizontal: 27),
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 23, horizontal: 19),
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(children: [
                                CustomFormField(
                                  title: "Email atau Username",
                                  controller: usernameController,
                                ),
                                const SizedBox(
                                  height: 17,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: greenColor,
                                                  width: 2.0),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: _obscureText
                                                  ? Icon(Icons.visibility_off, color: greenColor,)
                                                  : Icon(Icons.visibility, color: greenColor,),
                                              onPressed: () {
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(12),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Lupa Kata Sandi?",
                                      style: greenTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                CustomFilledButton(
                                  title: "Masuk",
                                  onPressed: () {
                                    if (validate()) {
                                      context.read<AuthBloc>().add(AuthLogin(
                                          SigninFormModel(
                                              password:
                                                  katasandiController.text,
                                              username:
                                                  usernameController.text)));
                                    } else {
                                      showCustomSnacKbar(
                                          context, "Semua form harus diisi!");
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 17,
                                )
                              ]),
                            ),
                            Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(top: 61),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Tidak mempunyai akun?",
                                              style: blackTextStyle.copyWith(
                                                  color: blackColor,
                                                  fontSize: 14),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero),
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    SignupPage.routeName);
                                              },
                                              child: Text(
                                                "Daftar",
                                                style: greenTextStyle.copyWith(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )))
                          ]),
                    ),
                  ))
            ])),
          );
        },
      ),
    );
  }
}
