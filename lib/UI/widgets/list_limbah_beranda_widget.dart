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
          child: image == ""
              ? Container(
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                      backgroundColor: whiteColor,
                      radius: 50, // Image radius
                      backgroundImage:
                          AssetImage("assets/image/user_no_profpic.png")))
              : Container(
                  width: 120,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: whiteColor,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FadeInImage(
                        placeholder:
                            AssetImage("assets/image/user_no_profpic.png"),
                        image: NetworkImage(image!),
                        fadeInDuration: Duration(
                            milliseconds: 300), // Set your desired duration
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ),
        ),
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
