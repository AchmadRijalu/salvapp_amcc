import 'package:flutter/material.dart';
import 'package:salvapp_amcc/common/common.dart';

class ListLimbahBerandaItem extends StatelessWidget {
  String? image;
  String? category;
  int? totalWeight;
  ListLimbahBerandaItem(
      {super.key,
      required this.category,
      this.image,
      required this.totalWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 155,
      height: 176,
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        Expanded(
            flex: 2,
            child: Container(
              child: Image.asset("assets/image/dummy1.png"),
            )),
        const SizedBox(
          height: 12,
        ),
        Expanded(
            child: Container(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Text(
                    "${totalWeight.toString()} Kg",
                    style: blackTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 14),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Text(
                    "${category}",
                    style: blackTextStyle.copyWith(
                        fontWeight: regular, fontSize: 14),
                  )
                ],
              ),
            )
          ]),
        )),
      ]),
    );
  }
}
