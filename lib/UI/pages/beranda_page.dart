import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salvapp_amcc/UI/widgets/list_limbah_beranda_widget.dart';
import 'package:salvapp_amcc/UI/widgets/list_penawaran_beranda_widget.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/beranda/beranda_bloc.dart';
import '../../blocs/shared/shared_methods.dart';
import '../../common/common.dart';
import '../widgets/list_limbah_widget.dart';

class BerandaPage extends StatefulWidget {
  static const routeName = '/beranda';
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  dynamic userId;
  dynamic userType;
  int? userPoint;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthSuccess) {
      userType = authState.user!.type;
      userId = authState.user!.id;
      userPoint = authState.user!.point;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider(
          create: (context) => BerandaBloc()..add(BerandaGetAllBuyer()),
          child: BlocConsumer<BerandaBloc, BerandaState>(
            listener: (context, state) {
              if (state is BerandaFailed) {
                showCustomSnacKbar(context, state.e);
              }
            },
            builder: (context, state) {
              if (state is BerandaLoading) {
                return Center(
                  child: LoadingAnimationWidget.twistingDots(
                    leftDotColor: greenColor,
                    rightDotColor: greenColor,
                    size: 40,
                  ),
                );
              }
              if (state is BerandaGetSuccess) {
                return Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: greenColor,
                          height: 118,
                          child: Stack(
                              clipBehavior: Clip.none,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Wah, lihat kontribusi \nlimbah makanan Anda!",
                                          style: whiteTextStyle.copyWith(
                                              fontSize: 16, fontWeight: medium),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  left: 26,
                                  right: 26,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            color: whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        width: 325,
                                        height: 40,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  "assets/image/image_point_user.png"),
                                              Text(
                                                  "Rp. ${userPoint.toString()}"),
                                              Text(" points")
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Expanded(
                          flex: 5,
                          child: Container(
                            color: Colors.transparent,
                            child: ListView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Berat Limbah yang Diberikan",
                                      style:
                                          blackTextStyle.copyWith(fontSize: 14),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                    height: 176,
                                    child:
                                        //  ListView(
                                        //   scrollDirection: Axis.horizontal,
                                        //   children:
                                        //   // Row(
                                        //   //   children: [
                                        //   //     ListLimbahBerandaItem(),
                                        //   //     ListLimbahBerandaItem(),
                                        //   //     ListLimbahBerandaItem()
                                        //   //   ],
                                        //   // ),
                                        // )
                                        ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 
                                      // state.beranda!.data[0].transactionCount,
                                      state.beranda!.data.length,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var limbah = state.beranda!.data[index];
                                        return ListLimbahBerandaItem(
                                            category: limbah.category,
                                            totalWeight: limbah.totalWeight);
                                      },
                                    )),
                                const SizedBox(
                                  height: 22,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Penawaran Terbaru",
                                      style:
                                          blackTextStyle.copyWith(fontSize: 14),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.beranda!.transactions.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var transaksi =
                                        state.beranda!.transactions[index];
                                    return ListPenawaranBerandaItem(
                                      createdAt:
                                          transaksi.createdAt.toIso8601String(),
                                      user: transaksi.user,
                                      title: transaksi.title,
                                      status: transaksi.status,
                                      total_price: transaksi.totalPrice,
                                    );
                                  },
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                );
              }
              return Container();
            },
          )),
    ));
  }
}

// Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 37),
//           child: Container(
//             child: Column(children: [
//               Expanded(
//                   child: Container(
//                       child: SingleChildScrollView(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Row(
//                         children: [
//                           if (userType == "seller") ...[
//                             Text(
//                               "Wah, limbah makanan \nmana yang paling sering \nAnda jual?  Yuk lihat-lihat!",
//                               style: blackTextStyle.copyWith(
//                                   fontSize: 20, fontWeight: FontWeight.w700),
//                             ),
//                           ] else if (userType == "buyer") ...[
//                             Text(
//                               "Wah, limbah makanan \nmana yang paling sering \nAnda beli?  Yuk lihat-lihat!",
//                               style: blackTextStyle.copyWith(
//                                   fontSize: 20, fontWeight: FontWeight.w700),
//                             )
//                           ],
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 17,
//                       ),
//                       const SizedBox(
//                         height: 6,
//                       ),
//                       if (userType == "3") ...[
//                         BlocProvider(
//                           create: (context) =>
//                               BerandaBloc()..add(BerandaGetAllSeller(userId)),
//                           child: BlocBuilder<BerandaBloc, BerandaState>(
//                             builder: (context, state) {
//                               if (state is BerandaLoading) {
//                                 return Container(
//                                     margin: const EdgeInsets.only(top: 40),
//                                     child: Center(
//                                       child: CircularProgressIndicator(
//                                           color: greenColor),
//                                     ));
//                               }
//                               if (state is BerandaSellerGetSuccess) {
//                                 return Text("sas");
//                                 // return ListView.builder(
//                                 //     shrinkWrap: true,
//                                 //     itemCount: state.berandaSeller!.data.length,
//                                 //     physics: NeverScrollableScrollPhysics(),
//                                 //     itemBuilder:
//                                 //         (BuildContext context, int index) {
//                                 //       var berandaSeller =
//                                 //           state.berandaSeller!.data[index];
//                                 //       return LimbahBerandaPage(
//                                 //         title: berandaSeller.category,
//                                 //         price: berandaSeller.finishedWeight,
//                                 //         onTap: () {},
//                                 //       );
//                                 //     });
//                               }
//                               if (state is BerandaFailed) {
//                                 return Center(
//                                   child: Text(
//                                     "Terjadi Kesalahan :(",
//                                     style: blackTextStyle.copyWith(
//                                         fontSize: 16, fontWeight: semiBold),
//                                   ),
//                                 );
//                               }
//                               return Container();
//                             },
//                           ),
//                         )

//                         //IN BUYER Side
//                       ] else if (userType == "buyer") ...[
//                         BlocProvider(
//                           create: (context) =>
//                               BerandaBloc()..add(BerandaGetAllBuyer(userId)),
//                           child: BlocBuilder<BerandaBloc, BerandaState>(
//                             builder: (context, state) {
//                               if (state is BerandaLoading) {
//                                 return Container(
//                                     margin: const EdgeInsets.only(top: 40),
//                                     child: Center(
//                                       child: CircularProgressIndicator(
//                                           color: greenColor),
//                                     ));
//                               }
//                               if (state is BerandaBuyerGetSuccess) {
//                                 return ListView.builder(
//                                   shrinkWrap: true,
//                                   itemCount: state.berandaBuyer!.data.length,
//                                   physics: NeverScrollableScrollPhysics(),
//                                   itemBuilder: (BuildContext context, int index) {
//                                     var berandaBuyer =
//                                         state.berandaBuyer!.data[index];
//                                     return LimbahBerandaPage(
//                                       title: "${berandaBuyer.category}",
//                                       price: berandaBuyer.finishedWeight,
//                                       onTap: () {},
//                                     );
//                                   },
//                                 );
//                               }
//                               if (state is BerandaFailed) {
//                                 return Center(
//                                   child: Text(
//                                     "Terjadi Kesalahan :(",
//                                     style: blackTextStyle.copyWith(
//                                         fontSize: 16, fontWeight: semiBold),
//                                   ),
//                                 );
//                               }
//                               return Container();
//                             },
//                           ),
//                         )
//                       ]
//                     ]),
//               )))
//             ]),
//           ),
//         ),
