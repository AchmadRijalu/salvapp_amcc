import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../common/common.dart';

class ListIklan extends StatelessWidget {
  String? id;
  String? title;
  String? category;
  int? price;
  String? user;
  String? image;

  final VoidCallback? onTap;
  ListIklan({
    super.key,
    this.id,
    this.image,
    this.title,
    this.onTap,
    this.category,
    this.price,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          width: double.infinity,
          color: Colors.transparent,
          height: 90,
          child: Row(children: [
            Expanded(
              child: image == ""
                  ? Container(
                      width: 120,
                      height: 120,
                      child: CircleAvatar(
                          backgroundColor: whiteColor,
                          radius: 42, // Image radius
                          backgroundImage:
                              AssetImage("assets/image/user_no_profpic.png")))
                  : Container(
                      width: 120,
                      child: CircleAvatar(
                        radius: 42,
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
              width: 12,
            ),
            Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Achmad Rijalu A",
                                      style:
                                          blackTextStyle.copyWith(fontSize: 8),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      "${title}",
                                      style:
                                          blackTextStyle.copyWith(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Sayur Sayuran",
                                          style: greyTextStyle.copyWith(
                                              fontSize: 8),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                        )),
                    Expanded(
                        child: Container(
                      child: Column(children: [
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Text(
                              "+ Rp. ${price},-kg",
                              style: blackTextStyle.copyWith(fontSize: 12),
                            )
                          ],
                        )
                      ]),
                    ))
                  ]),
                )),
          ]),
        ));
  }
}

class ListIklanPabrik extends StatelessWidget {
  String? id;
  String? title;
  String? category;
  int? price;
  String? user;
  String? image;

  final VoidCallback? onTap;
  ListIklanPabrik({
    super.key,
    this.id,
    this.image,
    this.title,
    this.onTap,
    this.category,
    this.price,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          width: double.infinity,
          color: Colors.transparent,
          height: 90,
          child: Row(children: [
            Expanded(
              child: image == ""
                  ? Container(
                      width: 120,
                      height: 120,
                      child: CircleAvatar(
                          backgroundColor: whiteColor,
                          radius: 42, // Image radius
                          backgroundImage:
                              AssetImage("assets/image/user_no_profpic.png")))
                  : Container(
                      width: 120,
                      child: CircleAvatar(
                        radius: 42,
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
              width: 12,
            ),
            Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Achmad Rijalu A",
                                      style:
                                          blackTextStyle.copyWith(fontSize: 8),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      "${title}",
                                      style:
                                          blackTextStyle.copyWith(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Sayur Sayuran",
                                          style: greyTextStyle.copyWith(
                                              fontSize: 8),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                        )),
                    Expanded(
                        child: Container(
                      child: Column(children: [
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Text(
                              "+ Rp. ${price},-kg",
                              style: blackTextStyle.copyWith(fontSize: 12),
                            )
                          ],
                        )
                      ]),
                    ))
                  ]),
                )),
          ]),
        ));
  }
}

// Container(
//         width: double.infinity,
//         margin: const EdgeInsets.only(bottom: 20),
//         decoration: BoxDecoration(boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             blurRadius: 2.0,
//             offset: Offset(0, 2), // changes the position of the shadow
//           ),
//         ], color: whiteColor, borderRadius: BorderRadius.circular(8)),
//         height: 160,
//         child:
//             Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//           Expanded(
//               flex: 3,
//               child: Container(
//                   child: Column(
//                 children: [
//                   Expanded(
//                     child: Row(children: [
//                       Expanded(
//                           flex: 3,
//                           child: Container(
//                             child: Column(children: [
//                               Expanded(
//                                 flex: 2,
//                                 child: Container(
//                                     padding: const EdgeInsets.only(
//                                         left: 21, top: 23),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.stretch,
//                                       children: [
//                                         Expanded(
//                                           child: Text(
//                                             title!,
//                                             overflow: TextOverflow.clip,
//                                             style: blackTextStyle.copyWith(
//                                                 fontSize: 16,
//                                                 fontWeight: semiBold),
//                                           ),
//                                         )
//                                       ],
//                                     )),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Expanded(
//                                   child: Container(
//                                 padding: const EdgeInsets.only(left: 21),
//                                 child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Flexible(
//                                           child: Row(
//                                         children: [
//                                           Text(
//                                             "+Rp. ${price}/kg",
//                                             style: blackTextStyle.copyWith(
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 10),
//                                           )
//                                         ],
//                                       )),
//                                       Flexible(
//                                           child: Container(
//                                         margin: const EdgeInsets.only(top: 2),
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               "Terkumpul ",
//                                               style: blackTextStyle.copyWith(
//                                                   fontSize: 10),
//                                             ),
//                                             Text("${onGoingWeight}",
//                                                 style: blackTextStyle.copyWith(
//                                                     fontWeight: FontWeight.w700,
//                                                     fontSize: 10)),
//                                             Text(" Kg",
//                                                 style: blackTextStyle.copyWith(
//                                                     fontWeight: FontWeight.w700,
//                                                     fontSize: 10)),
//                                             Text(
//                                               "/ ${requestedWeight} kg ",
//                                               style: blackTextStyle.copyWith(
//                                                   fontSize: 10),
//                                             ),
//                                           ],
//                                         ),
//                                       ))
//                                     ]),
//                               ))
//                             ]),
//                           )),
//                       // Expanded(
//                       //     flex: 2,
//                       //     child: Container(
//                       //       child: Align(
//                       //           alignment: Alignment.topRight,
//                       //           child: Image.asset(
//                       //             "assets/image/image_sampah.png",
//                       //             fit: BoxFit.fill,
//                       //           )),
//                       //     )),
//                     ]),
//                   ),
//                 ],
//               ))),
//           const SizedBox(
//             height: 5,
//           ),
//           Expanded(
//               flex: 2,
//               child: Container(
//                 child: Column(children: [
//                   Flexible(
//                       child: Container(
//                     margin: const EdgeInsets.only(left: 9),
//                     child: LinearPercentIndicator(
//                       lineHeight: 27,
//                       percent: onGoingWeight / requestedWeight,
//                       animation: true,
//                       progressColor: greenColor,
//                       backgroundColor: greyColor,
//                       barRadius: Radius.circular(8),
//                     ),
//                   )),
//                   Expanded(
//                       child: Container(
//                     padding: const EdgeInsets.only(right: 20, left: 21),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "0 Kg",
//                           style: blackTextStyle.copyWith(fontSize: 16),
//                         ),
//                         Text(
//                           "${requestedWeight}",
//                           style: blackTextStyle.copyWith(fontSize: 16),
//                         )
//                       ],
//                     ),
//                   ))
//                 ]),
//               ))
//         ]),
//       ),
