import 'package:flutter/material.dart';
import 'package:salvapp_amcc/common/common.dart';

class ListPenawaranBerandaItem extends StatelessWidget {
  String? statusPenawaran;
  String? image;
  String? title;
  String? user;
  int? total_price;
  String? createdAt;
  ListPenawaranBerandaItem(
      {super.key,
      this.statusPenawaran,
      this.title,
      this.user,
      this.total_price,
      this.image,
      this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      height: 65,
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(4)),
      width: double.infinity,
      child: Row(children: [
        Expanded(
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
        Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(9),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${statusPenawaran}",
                              style: blackTextStyle.copyWith(fontSize: 8),
                            ),
                            Text(
                              "Rp. ${total_price.toString()}",
                              style: blackTextStyle.copyWith(fontSize: 8),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "${title}",
                              style: blackTextStyle.copyWith(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        Text(
                          "${user}",
                          style: blackTextStyle.copyWith(fontSize: 8),
                        ),
                      ],
                    ),
                  ]),
            ))
      ]),
    );
  }
}
