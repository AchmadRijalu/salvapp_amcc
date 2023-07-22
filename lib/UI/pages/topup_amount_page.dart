import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:salvapp_amcc/UI/pages/webview_midtrans_page.dart';
import 'package:salvapp_amcc/models/topup_form_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/shared/shared_methods.dart';
import '../../common/common.dart';
import '../widgets/buttons.dart';

class TopupAmountPage extends StatefulWidget {
  final TopupFormModel? topupFormModel;
  static const routeName = '/topupamount';
  const TopupAmountPage({super.key, this.topupFormModel});

  @override
  State<TopupAmountPage> createState() => _TopupAmountPageState();
}

class _TopupAmountPageState extends State<TopupAmountPage> {
  final TextEditingController amountController =
      TextEditingController(text: '0');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amountController.addListener(() {
      final text = amountController.text;
      amountController.value = amountController.value.copyWith(
          text:
              NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: '')
                  .format(int.tryParse(text.replaceAll('.', '')) ?? 0));
    });
  }

  void addAmount(String number) {
    if (amountController.text == '0') {
      amountController.text = '';
    }
    setState(() {
      amountController.text = amountController.text + number;
    });
  }

  deleteAmount() {
    if (amountController.text.isNotEmpty) {
      setState(() {
        amountController.text = amountController.text
            .substring(0, amountController.text.length - 1);
      });
      if (amountController.text == '') {
        amountController.text = "0";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Total Jumlah",
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
        ),
      ),
      backgroundColor: whiteColor,
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 58),
          children: [
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 230,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  enabled: false,
                  controller: amountController,
                  cursorColor: blackColor,
                  style:
                      blackTextStyle.copyWith(fontSize: 36, fontWeight: medium),
                  decoration: InputDecoration(
                      prefix: Text(
                        "Rp. ",
                        style: blackTextStyle.copyWith(
                            fontSize: 36, fontWeight: medium),
                      ),
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyColor))),
                ),
              ),
            ),
            const SizedBox(
              height: 66,
            ),
            Wrap(
              spacing: 40,
              runSpacing: 40,
              children: [
                CustomInputButton(
                  title: "1",
                  onTap: () {
                    addAmount("1");
                  },
                ),
                CustomInputButton(
                  title: "2",
                  onTap: () {
                    addAmount("2");
                  },
                ),
                CustomInputButton(
                  title: "3",
                  onTap: () {
                    addAmount("3");
                  },
                ),
                CustomInputButton(
                  title: "4",
                  onTap: () {
                    addAmount("4");
                  },
                ),
                CustomInputButton(
                  title: "5",
                  onTap: () {
                    addAmount("5");
                  },
                ),
                CustomInputButton(
                  title: "6",
                  onTap: () {
                    addAmount("6");
                  },
                ),
                CustomInputButton(
                  title: "7",
                  onTap: () {
                    addAmount("7");
                  },
                ),
                CustomInputButton(
                  title: "8",
                  onTap: () {
                    addAmount("8");
                  },
                ),
                CustomInputButton(
                  title: "9",
                  onTap: () {
                    addAmount("9");
                  },
                ),
                const SizedBox(
                  width: 60,
                  height: 60,
                ),
                CustomInputButton(
                  title: "0",
                  onTap: () {
                    addAmount("0");
                  },
                ),
                GestureDetector(
                  onTap: (() {
                    deleteAmount();
                  }),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: blackColor),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: whiteColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            CustomFilledButton(
              title: "Top Up Sekarang",
              onPressed: () async {
                // if (await Navigator.pushNamed(context, '/pin') == true) {
                //   await launchUrl(Uri.parse("https://demo.midtrans.com/"));
                //   Navigator.pushNamedAndRemoveUntil(
                //       context, '/topup-success', (route) => false);
                // }
                if (amountController.text == '0') {
                  showCustomSnacKbar(context, "Jumlah Topup tidak boleh 0");
                  return;
                } else {
                  // print(amountController.text.replaceAll('.', ''));
                  Navigator.pushNamed(context, WebviewMidtransPage.routeName,
                      arguments: TopupFormModel(
                          amount: amountController.text.replaceAll('.', '')));
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            CustomTextButton(
              title: "Terms and Condition",
              onPressed: () {},
            ),
            const SizedBox(
              height: 40,
            ),
          ]),
    );
  }
}
