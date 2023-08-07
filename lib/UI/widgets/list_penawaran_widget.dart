import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../common/common.dart';

class ListPenawaran extends StatelessWidget {
  final String? namaLimbah;
  final String? username;
  final String? totalPrice;
  final String? image;
  final VoidCallback? onTap;
  final String? statusPenawaran;
  const ListPenawaran(
      {super.key,
      required this.namaLimbah,
      this.onTap,
      required this.totalPrice,
      this.image,
      required this.statusPenawaran,
      required this.username});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 72,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 2.0,
                offset: Offset(0, 2), // changes the position of the shadow
              ),
            ],
            // color: statusPenawaran == 'Respon' ||
            //         statusPenawaran == "Sedang Berlangsung" ||
            //         statusPenawaran == "Menunggu Konfirmasi"
            //     ? greenColor
            //     : whiteColor,
            color: whiteColor,
            borderRadius: BorderRadius.circular(8)),
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
                height: double.infinity,
                padding: const EdgeInsets.all(7),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${statusPenawaran!}",
                        style: statusPenawaran == "Dibatalkan" ||
                                statusPenawaran == "Ditolak"
                            ? redTextStyle.copyWith(fontSize: 10)
                            : statusPenawaran == "Diterima"
                                ? blueTextStyle.copyWith(fontSize: 10)
                                : statusPenawaran == "Sedang Berlangsung"
                                    ? greenTextStyle.copyWith(fontSize: 10)
                                    : statusPenawaran == "Menunggu Konfirmasi" || statusPenawaran == "Menunggu Respon"
                                        ? TextStyle(color: Color(0xffAEB100),fontSize: 10)
                                        : blackTextStyle.copyWith(fontSize: 10),
                      ),
                      Text(
                        "${totalPrice!}",
                        style: blackTextStyle.copyWith(
                            fontSize: 10, fontWeight: bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        "${namaLimbah!}",
                        style: blackTextStyle.copyWith(
                            fontSize: 12, fontWeight: semiBold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      Text(
                        "${username!}",
                        style: blackTextStyle.copyWith(
                            fontSize: 12, fontWeight: medium),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ]),
              ))
        ]),
      ),
    );
  }
}

// Container(
//                         color: Colors.amber,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(statusPenawaran!,
//                                     textAlign: TextAlign.center,
//                                     style: statusPenawaran == 'Respon' ||
//                                             statusPenawaran ==
//                                                 "Menunggu Konfirmasi"
//                                         ? greenTextStyle.copyWith(
//                                             fontSize: 12, fontWeight: semiBold)
//                                         : statusPenawaran == "Diterima"
//                                             ? greenTextStyle.copyWith(
//                                                 fontSize: 12,
//                                                 fontWeight: semiBold)
//                                             : statusPenawaran == "Dibatalkan" ||
//                                                     statusPenawaran == "Ditolak"
//                                                 ? redTextStyle.copyWith(
//                                                     fontSize: 12,
//                                                     fontWeight: semiBold)
//                                                 : statusPenawaran ==
//                                                         "Sedang Berlangsung"
//                                                     ? greenTextStyle.copyWith(
//                                                         fontSize: 12,
//                                                         fontWeight: semiBold)
//                                                     : whiteTextStyle.copyWith(
//                                                         fontSize: 12,
//                                                         fontWeight: semiBold)),
//                                 Text(totalPrice.toString()),
//                               ],
//                             ),
//                             Expanded(
//                                 flex: 2,
//                                 child: Container(
//                                   padding: const EdgeInsets.all(4),
//                                   width: double.infinity,
//                                   child: Text(namaLimbah!,
//                                       overflow: TextOverflow.clip,
//                                       style: statusPenawaran == 'Respon' ||
//                                               statusPenawaran ==
//                                                   "Sedang Berlangsung" ||
//                                               statusPenawaran ==
//                                                   "Menunggu Konfirmasi"
//                                           ? blackTextStyle.copyWith(
//                                               fontWeight: medium)
//                                           : blackTextStyle.copyWith(
//                                               fontWeight: medium)),
//                                 )),
//                             Flexible(
//                                 child: Container(
//                               width: double.infinity,
//                               child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       username!,
//                                       style: statusPenawaran == 'Respon' ||
//                                               statusPenawaran ==
//                                                   "Sedang Berlangsung" ||
//                                               statusPenawaran ==
//                                                   "Menunggu Konfirmasi"
//                                           ? blackTextStyle.copyWith(fontSize: 8)
//                                           : blackTextStyle.copyWith(
//                                               fontSize: 8),
//                                     )
//                                   ]),
//                             )

//  Flexible(
//                       child: Column(
//                     children: [
//                       Expanded(
//                           flex: 2,
//                           child: Container(
//                             child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Flexible(
//                                     child: Container(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         children: [
//                                           // Text(
//                                           //   tanggal!,
//                                           //   style: statusPenawaran == 'Respon' ||
//                                           //           statusPenawaran ==
//                                           //               "Sedang Berlangsung" ||
//                                           //           statusPenawaran ==
//                                           //               "Menunggu Konfirmasi"
//                                           //       ? whiteTextStyle.copyWith(
//                                           //           fontSize: 7, fontWeight: medium)
//                                           //       : greenTextStyle.copyWith(
//                                           //           fontSize: 7,
//                                           //           fontWeight: medium),
//                                           // )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                       child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [],
//                                   ))
//                                 ]),
//                           )),
//                       // Expanded(
//                       //     child: Container(
//                       //         width: double.infinity,
//                       //         decoration: BoxDecoration(
//                       //             color: statusPenawaran == "Konfirmasi"
//                       //                 ? greenColor
//                       //                 : whiteColor,
//                       //             borderRadius: BorderRadius.circular(8)),
//                       //         child: Column(
//                       //           mainAxisAlignment: MainAxisAlignment.center,
//                       //           crossAxisAlignment: CrossAxisAlignment.center,
//                       //           children: [

//                       //           ],
//                       //         )))
//                     ],
//                   ))
