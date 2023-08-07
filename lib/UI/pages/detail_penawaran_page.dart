import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:salvapp_amcc/UI/pages/batal_iklan_page.dart';
import 'package:salvapp_amcc/UI/pages/batal_penawaran_page.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/shared/shared_methods.dart';
import '../../blocs/transaksi/transaksi_bloc.dart';
import '../../common/common.dart';
import 'holder_page.dart';

class DetailPenawaranPage extends StatefulWidget {
  final String? transactionId;
  final String? statusPenawaran;
  static const routeName = '/detailpenawaran';
  const DetailPenawaranPage(
      {super.key, this.transactionId, this.statusPenawaran});

  @override
  State<DetailPenawaranPage> createState() => _DetailPenawaranPageState();
}

class _DetailPenawaranPageState extends State<DetailPenawaranPage> {
  int status = 0;
  dynamic userId;
  dynamic userType;
  late TransaksiBloc _transaksiBloc;
  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      userType = authState.user!.type;
      userId = authState.user!.id;
    }
    if (userType == 2) {
      _transaksiBloc = TransaksiBloc()
        ..add(TransaksiGetDetailBuyer(widget.transactionId));
    } else if (userType == 3) {
      _transaksiBloc = TransaksiBloc()
        ..add(TransaksiGetDetailSeller(widget.transactionId));
    }
    print(widget.statusPenawaran);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: whiteColor, //change your color here
        ),
        title: Text(
          "Detail Penawaran",
          style: whiteTextStyle.copyWith(
            color: whiteColor,
            fontWeight: medium,
          ),
        ),
        backgroundColor: greenColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 17),
        child: Container(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(children: [
                  userType == 2
                      ? Expanded(
                          child: Container(
                          color: lightBackgroundColor,
                          child: BlocProvider(
                            create: (context) => _transaksiBloc,
                            child: BlocConsumer<TransaksiBloc, TransaksiState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is DetailTransaksiBuyerGetSuccess) {
                                  var detailTransaksi =
                                      state.detailTransaksiBuyer!.data;
                                  return Column(
                                    children: [
                                      // Text(widget.statusPenawaran!),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${detailTransaksi.ongoingWeight.toString()}",
                                              style: blackTextStyle.copyWith(
                                                  fontSize: 48,
                                                  fontWeight: regular)),
                                          // ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 48,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                " / ${detailTransaksi.requestedWeight.toString()}",
                                                                style: blackTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18),
                                                              ),
                                                              Text(
                                                                "Gram",
                                                                style: blueTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      const SizedBox(
                                        height: 29,
                                      ),
                                      Flexible(
                                          child: Container(
                                        margin: const EdgeInsets.only(left: 9),
                                        child: LinearPercentIndicator(
                                          lineHeight: 27,
                                          percent: detailTransaksi
                                                  .ongoingWeight /
                                              detailTransaksi.requestedWeight,
                                          animation: true,
                                          progressColor: greenColor,
                                          backgroundColor: Colors.grey[350],
                                          barRadius: Radius.circular(8),
                                        ),
                                      )),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Flexible(
                                          child: Container(
                                        padding: const EdgeInsets.only(
                                            right: 20, left: 21),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "0 Gram",
                                              style: blueTextStyle.copyWith(
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              "${detailTransaksi.requestedWeight.toString()}Gram",
                                              style: blueTextStyle.copyWith(
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      )),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      Divider(
                                        color: greyColor,
                                      ),
                                      const SizedBox(
                                        height: 21,
                                      ),
                                      Container(
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                  child: Wrap(children: [
                                                Text(
                                                  detailTransaksi.title,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: regular),
                                                )
                                              ])),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                detailTransaksi.category,
                                                style: greyTextStyle.copyWith(
                                                    fontWeight: regular),
                                              ))
                                            ],
                                          )
                                        ]),
                                      ),
                                      Divider(
                                        color: greyColor,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      "Spesifikasi Permintaan Limbah")
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              detailTransaksi
                                                          .additionalInformation ==
                                                      ""
                                                  ? Text(
                                                      "-",
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontWeight:
                                                                  semiBold,
                                                              fontSize: 14),
                                                    )
                                                  : Text(
                                                      "${detailTransaksi.additionalInformation}",
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontWeight:
                                                                  semiBold,
                                                              fontSize: 14),
                                                    )
                                            ]),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Divider(
                                        color: greyColor,
                                      ),
                                      const SizedBox(
                                        height: 21,
                                      ),
                                      Row(
                                        children: [
                                          Text("Data Pengiriman "),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 19,
                                      ),
                                      Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17,
                                                        vertical: 16),
                                                decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Berat yang Diberikan",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        "${detailTransaksi.requestedWeight} Gram",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    regular),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 24,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      // Text(
                                                      //   userType == 3
                                                      //       ? "Pengeluaran"
                                                      //       : "Pendapatan",
                                                      //   style: blackTextStyle,
                                                      // ),
                                                      Text(
                                                        "Total Pendapatan",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        "Rp. ${detailTransaksi.totalPrice}",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    regular),
                                                      )
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                            ]),
                                      ),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      const SizedBox(height: 30),
                                      if (widget.statusPenawaran == "0") ...[
                                        BlocProvider(
                                          create: (context) => _transaksiBloc,
                                          child: BlocConsumer<TransaksiBloc,
                                              TransaksiState>(
                                            listener: (context, state) {
                                              if (state
                                                  is AksiTransaksiBuyerGetSuccess) {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        HolderPage.routeName,
                                                        (route) => false);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state is TransaksiLoading) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                              if (state
                                                  is DetailTransaksiBuyerGetSuccess) {
                                                // var detailTransaksi =
                                                //     state.detailTransaksiBuyer!.data;
                                                return Flexible(
                                                    child: Container(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Flexible(
                                                            child: Container(
                                                                child:
                                                                    GestureDetector(
                                                          onTap: () {},
                                                          child: SizedBox(
                                                            width: 144,
                                                            height: 50,
                                                            child: TextButton(
                                                              style: TextButton.styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8))),
                                                              onPressed: () {
                                                                //TODO: Tolak
                                                                status = 3;
                                                                print(
                                                                    "TOLAK: Status ${status}");
                                                                _transaksiBloc.add(
                                                                    AksiTransaksiGetBuyer(
                                                                        widget
                                                                            .transactionId,
                                                                        3));
                                                                Navigator.pushNamedAndRemoveUntil(
                                                                    context,
                                                                    HolderPage
                                                                        .routeName,
                                                                    (route) =>
                                                                        false);
                                                              },
                                                              child: Text(
                                                                "Tolak",
                                                                style: whiteTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            semiBold),
                                                              ),
                                                            ),
                                                          ),
                                                        ))),
                                                        SizedBox(
                                                          width: 12,
                                                        ),
                                                        Flexible(
                                                          child: Container(
                                                              child:
                                                                  GestureDetector(
                                                            onTap: () {},
                                                            child: SizedBox(
                                                              width: 144,
                                                              height: 50,
                                                              child: TextButton(
                                                                style: TextButton.styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8))),
                                                                onPressed: () {
                                                                  //TODO: Terima
                                                                  status = 1;
                                                                  print(
                                                                      "Konfirmasi: Status ${status}");
                                                                  _transaksiBloc.add(
                                                                      AksiTransaksiGetBuyer(
                                                                          widget
                                                                              .transactionId,
                                                                          1));
                                                                  Navigator.pushNamedAndRemoveUntil(
                                                                      context,
                                                                      HolderPage
                                                                          .routeName,
                                                                      (route) =>
                                                                          false);
                                                                },
                                                                child: Text(
                                                                  "Terima",
                                                                  style: whiteTextStyle.copyWith(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          semiBold),
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                        )
                                                      ]),
                                                ));
                                              }
                                              if (state
                                                  is DetailTransaksiBuyerFailed) {
                                                return Center(
                                                  child: Text(
                                                    "Terjadi Kesalahan :(",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                semiBold),
                                                  ),
                                                );
                                              }
                                              return Container();
                                            },
                                          ),
                                        )
                                      ],
                                      if (widget.statusPenawaran == "1") ...[
                                        BlocProvider(
                                          create: (context) => _transaksiBloc,
                                          child: BlocConsumer<TransaksiBloc,
                                              TransaksiState>(
                                            listener: (context, state) {
                                              if (state
                                                  is AksiTransaksiFinalBuyerGetSuccess) {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        HolderPage.routeName,
                                                        (route) => false);
                                              }
                                            },
                                            builder: (context, state) {
                                              // var detailTransaksi =
                                              //     state.detailTransaksiBuyer!.data;
                                              return Flexible(
                                                  child: Container(
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Flexible(
                                                          child: Container(
                                                              child:
                                                                  GestureDetector(
                                                        onTap: () {},
                                                        child: SizedBox(
                                                          width: 144,
                                                          height: 50,
                                                          child: TextButton(
                                                            style: TextButton.styleFrom(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8))),
                                                            onPressed: () {
                                                              //TODO: Tolak
                                                              status = 4;
                                                              print(
                                                                  "Batal: Status ${status}");
                                                              context
                                                                  .read<
                                                                      TransaksiBloc>()
                                                                  .add(AksiTransaksiGetBuyer(
                                                                      widget
                                                                          .transactionId,
                                                                      4));
                                                              Navigator.pushNamedAndRemoveUntil(
                                                                  context,
                                                                  HolderPage
                                                                      .routeName,
                                                                  (route) =>
                                                                      false);
                                                            },
                                                            child: Text(
                                                              "Batalkan",
                                                              style: whiteTextStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          semiBold),
                                                            ),
                                                          ),
                                                        ),
                                                      ))),
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                            child:
                                                                GestureDetector(
                                                          onTap: () {},
                                                          child: SizedBox(
                                                            width: 144,
                                                            height: 50,
                                                            child: TextButton(
                                                              style: TextButton.styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8))),
                                                              onPressed: () {
                                                                //TODO: Terima
                                                                status = 2;
                                                                print(
                                                                    "TERIMA: Status ${status}");
                                                                context
                                                                    .read<
                                                                        TransaksiBloc>()
                                                                    .add(AksiTransaksiGetBuyer(
                                                                        widget
                                                                            .transactionId,
                                                                        2));
                                                                Navigator.pushNamedAndRemoveUntil(
                                                                    context,
                                                                    HolderPage
                                                                        .routeName,
                                                                    (route) =>
                                                                        false);
                                                              },
                                                              child: Text(
                                                                "Selesai",
                                                                style: whiteTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            semiBold),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                      )
                                                    ]),
                                              ));
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        )
                                      ],
                                      if (widget.statusPenawaran == "3") ...[
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // Text("data"),
                                                Image.asset(
                                                  "assets/image/cross.png",
                                                  width: 60,
                                                  height: 60,
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  "Penawaran Dibatalkan",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: semiBold),
                                                )
                                              ]),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        )
                                      ],
                                      if (widget.statusPenawaran == "4") ...[
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/image/cross.png",
                                                  width: 60,
                                                  height: 60,
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  "Penawaran Dibatalkan",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: semiBold),
                                                )
                                              ]),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        )
                                      ],
                                      if (widget.statusPenawaran == "2") ...[
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Column(children: [
                                            Image.asset(
                                              "assets/image/check.png",
                                              width: 100,
                                              height: 100,
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "Penawaran Telah Diterima",
                                              style: greenTextStyle.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: semiBold),
                                            )
                                          ]),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        )
                                      ],
                                    ],
                                  );
                                }
                                if (state is DetailTransaksiBuyerFailed) {
                                  return Center(
                                    child: Text(
                                      "Terjadi Kesalahan :(",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16, fontWeight: semiBold),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                        ))
                      : Expanded(
                          child: Container(
                          color: lightBackgroundColor,
                          child: BlocProvider(
                            create: (context) => _transaksiBloc,
                            child: BlocConsumer<TransaksiBloc, TransaksiState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is DetailTransaksiSellerGetSuccess) {
                                  var detailTransaksi =
                                      state.detailTransaksiSeller!.data;
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${detailTransaksi.ongoingWeight.toString()}",
                                              style: blackTextStyle.copyWith(
                                                  fontSize: 48,
                                                  fontWeight: regular)),
                                          // ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 48,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                " / ${detailTransaksi.requestedWeight.toString()}",
                                                                style: blackTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18),
                                                              ),
                                                              Text(
                                                                "Gram",
                                                                style: blueTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      const SizedBox(
                                        height: 29,
                                      ),
                                      Flexible(
                                          child: Container(
                                        margin: const EdgeInsets.only(left: 9),
                                        child: LinearPercentIndicator(
                                          lineHeight: 27,
                                          percent: detailTransaksi
                                                  .ongoingWeight /
                                              detailTransaksi.requestedWeight,
                                          animation: true,
                                          progressColor: greenColor,
                                          backgroundColor: Colors.grey[350],
                                          barRadius: Radius.circular(8),
                                        ),
                                      )),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Flexible(
                                          child: Container(
                                        padding: const EdgeInsets.only(
                                            right: 20, left: 21),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "0 Gram",
                                              style: blueTextStyle.copyWith(
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              "${detailTransaksi.requestedWeight.toString()}Gram",
                                              style: blueTextStyle.copyWith(
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      )),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      Divider(
                                        color: greyColor,
                                      ),
                                      const SizedBox(
                                        height: 21,
                                      ),
                                      Container(
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                  child: Wrap(children: [
                                                Text(
                                                  detailTransaksi.title,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontSize: 16,
                                                          fontWeight: regular),
                                                )
                                              ])),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                detailTransaksi.category,
                                                style: greyTextStyle.copyWith(
                                                    fontWeight: regular),
                                              ))
                                            ],
                                          )
                                        ]),
                                      ),
                                      Divider(
                                        color: greyColor,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      "Spesifikasi Permintaan Limbah")
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              detailTransaksi
                                                          .additionalInformation ==
                                                      ""
                                                  ? Text(
                                                      "-",
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontWeight:
                                                                  semiBold,
                                                              fontSize: 14),
                                                    )
                                                  : Text(
                                                      "${detailTransaksi.additionalInformation}",
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontWeight:
                                                                  semiBold,
                                                              fontSize: 14),
                                                    )
                                            ]),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Divider(
                                        color: greyColor,
                                      ),
                                      const SizedBox(
                                        height: 21,
                                      ),
                                      Row(
                                        children: [
                                          Text("Data Pengiriman "),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 19,
                                      ),
                                      Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17,
                                                        vertical: 16),
                                                decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Berat yang Diberikan",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        "${detailTransaksi.requestedWeight} Gram",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    regular),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 24,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      // Text(
                                                      //   userType == 3
                                                      //       ? "Pengeluaran"
                                                      //       : "Pendapatan",
                                                      //   style: blackTextStyle,
                                                      // ),
                                                      Text(
                                                        "Total Pendapatan",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        "Rp. ${detailTransaksi.totalPrice}",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    regular),
                                                      )
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                            ]),
                                      ),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      const SizedBox(height: 30),
                                      if (widget.statusPenawaran == "0") ...[
                                        BlocProvider(
                                          create: (context) => _transaksiBloc,
                                          child: BlocConsumer<TransaksiBloc,
                                              TransaksiState>(
                                            listener: (context, state) {
                                              // TODO: implement listener
                                              if (state
                                                  is AksiTransaksiSellerGetSuccess) {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        BatalPenawaranPage
                                                            .routeName,
                                                        (route) => false);
                                              }
                                              if (state
                                                  is AksiTransaksiSellerFailed) {
                                                showCustomSnacKbar(
                                                    context, state.e);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is AksiTransaksiLoading) {}

                                              return GestureDetector(
                                                onTap: () {},
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  height: 50,
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                        backgroundColor:
                                                            greenColor,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8))),
                                                    onPressed: () {
                                                      context
                                                          .read<TransaksiBloc>()
                                                          .add(AksiTransaksiGetSeller(
                                                              widget
                                                                  .transactionId,
                                                              4));
                                                    },
                                                    child: Text(
                                                      "Batalkan Penawaran",
                                                      style: whiteTextStyle
                                                          .copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  semiBold),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                      if (widget.statusPenawaran == "1") ...[
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.green.shade600),
                                          width: 100,
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: '',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: semiBold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        "Penawaran Telah Diterima oleh Pembeli !",
                                                    style:
                                                        whiteTextStyle.copyWith(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                medium)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        )
                                      ] else if (widget.statusPenawaran ==
                                          "2") ...[
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: whiteColor),
                                          width: double.infinity,
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: '',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: semiBold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        "Yuk Segera Antar Penawaran Limbahmu !",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                semiBold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        )
                                      ] else if (widget.statusPenawaran ==
                                          "3") ...[
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: redColor),
                                          width: double.infinity,
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: '',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: semiBold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        "Penawaran Telah Dibatalkan!",
                                                    style:
                                                        whiteTextStyle.copyWith(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                semiBold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        )
                                      ] else if (widget.statusPenawaran ==
                                          "4") ...[
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: redColor),
                                          width: 300,
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: '',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: semiBold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        "Penawaran Telah Dibatalkan !",
                                                    style:
                                                        whiteTextStyle.copyWith(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                semiBold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        )
                                      ]
                                    ],
                                  );
                                }
                                if (state is DetailTransaksiBuyerFailed) {
                                  return Center(
                                    child: Text(
                                      "Terjadi Kesalahan :(",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16, fontWeight: semiBold),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                        ))

                  // if (userType == 2) ...[
                  //   BlocProvider(
                  //     create: (context) => TransaksiBloc()
                  //       ..add(TransaksiGetDetailBuyer(widget.transactionId)),
                  //     child: BlocConsumer<TransaksiBloc, TransaksiState>(
                  //       listener: (context, state) {
                  //         if (state is AksiTransaksiBuyerGetSuccess) {
                  //           Navigator.pushNamedAndRemoveUntil(context,
                  //               HolderPage.routeName, (route) => false);
                  //         }
                  //       },
                  //       builder: (context, state) {
                  //         if (state is DetailTransaksiBuyerGetSuccess) {
                  //           var detailTransaksi =
                  //               state.detailTransaksiBuyer!.data;
                  //           print(detailTransaksi.image);
                  //           return Flexible(
                  //               flex: 4,
                  //               child: Container(
                  //                 child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       if (detailTransaksi.image != "" ||
                  //                           detailTransaksi != null) ...[
                  //                         Container(
                  //                           margin: const EdgeInsets.only(
                  //                               top: 12, bottom: 12),
                  //                           child: Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment.center,
                  //                             children: [
                  //                               Image.network(
                  //                                 detailTransaksi.image!,
                  //                                 width: 200,
                  //                                 height: 200,
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ] else ...[
                  //                         Container(),
                  //                       ],
                  //                       Container(
                  //                         width: double.infinity,
                  //                         padding: const EdgeInsets.symmetric(
                  //                             horizontal: 17, vertical: 16),
                  //                         decoration: BoxDecoration(
                  //                             color: whiteColor,
                  //                             borderRadius:
                  //                                 BorderRadius.circular(8)),
                  //                         child: Column(children: [
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Flexible(
                  //                                   child: Wrap(
                  //                                 children: [
                  //                                   Text(
                  //                                     detailTransaksi.title
                  //                                         .toString(),
                  //                                     style: blackTextStyle
                  //                                         .copyWith(
                  //                                             fontWeight:
                  //                                                 FontWeight
                  //                                                     .w600),
                  //                                   )
                  //                                 ],
                  //                               ))
                  //                             ],
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Divider(
                  //                             color: greyColor,
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Text(
                  //                                 "Kategori",
                  //                                 style: blackTextStyle,
                  //                               ),
                  //                               Text(
                  //                                 detailTransaksi.category
                  //                                     .toString(),
                  //                                 style:
                  //                                     blackTextStyle.copyWith(
                  //                                         fontWeight:
                  //                                             FontWeight.w600),
                  //                               )
                  //                             ],
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Divider(
                  //                             color: greyColor,
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Text(
                  //                                 "Spesifikasi",
                  //                                 style: blackTextStyle,
                  //                               ),
                  //                               Text(
                  //                                 detailTransaksi
                  //                                     .additionalInformation
                  //                                     .toString(),
                  //                                 style:
                  //                                     blackTextStyle.copyWith(
                  //                                         fontWeight:
                  //                                             FontWeight.w600),
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ]),
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 25,
                  //                       ),
                  //                       Text(
                  //                         "Ketentuan",
                  //                         style: blackTextStyle.copyWith(
                  //                             fontWeight: FontWeight.w700,
                  //                             fontSize: 20),
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 20,
                  //                       ),
                  //                       Container(
                  //                         width: double.infinity,
                  //                         padding: const EdgeInsets.symmetric(
                  //                             horizontal: 17, vertical: 16),
                  //                         decoration: BoxDecoration(
                  //                             color: whiteColor,
                  //                             borderRadius:
                  //                                 BorderRadius.circular(8)),
                  //                         child: Column(children: [
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Text(
                  //                                 "Tanggal Kadaluarsa",
                  //                                 style: blackTextStyle,
                  //                               ),
                  //                               Text(
                  //                                 "-",
                  //                                 style:
                  //                                     blackTextStyle.copyWith(
                  //                                         fontWeight:
                  //                                             FontWeight.w600),
                  //                               )
                  //                             ],
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Divider(
                  //                             color: greyColor,
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Text(
                  //                                 "Berat Minimum",
                  //                                 style: blackTextStyle,
                  //                               ),
                  //                               Text(
                  //                                 "${detailTransaksi.minimumWeight} g",
                  //                                 style:
                  //                                     blackTextStyle.copyWith(
                  //                                         fontWeight:
                  //                                             FontWeight.w600),
                  //                               )
                  //                             ],
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Divider(
                  //                             color: greyColor,
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Text(
                  //                                 "Berat Maksimum",
                  //                                 style: blackTextStyle,
                  //                               ),
                  //                               Text(
                  //                                 "${detailTransaksi.minimumWeight} kg",
                  //                                 style:
                  //                                     blackTextStyle.copyWith(
                  //                                         fontWeight:
                  //                                             FontWeight.w600),
                  //                               )
                  //                             ],
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Divider(
                  //                             color: greyColor,
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Text(
                  //                                 "Pendapatan",
                  //                                 style: blackTextStyle,
                  //                               ),
                  //                               Text(
                  //                                 "+ Rp${detailTransaksi.price},- / kg",
                  //                                 style:
                  //                                     blackTextStyle.copyWith(
                  //                                         fontWeight:
                  //                                             FontWeight.w600),
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ]),
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 25,
                  //                       ),
                  //                       Text(
                  //                         "Data Pengiriman",
                  //                         style: blackTextStyle.copyWith(
                  //                             fontWeight: FontWeight.w700,
                  //                             fontSize: 20),
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 20,
                  //                       ),
                  //                       Container(
                  //                         width: double.infinity,
                  //                         padding: const EdgeInsets.symmetric(
                  //                             horizontal: 17, vertical: 16),
                  //                         decoration: BoxDecoration(
                  //                             color: whiteColor,
                  //                             borderRadius:
                  //                                 BorderRadius.circular(8)),
                  //                         child: Column(children: [
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Text(
                  //                                 "Berat yang Diberikan",
                  //                                 style: blackTextStyle,
                  //                               ),
                  //                               Text(
                  //                                 "${detailTransaksi.weight} kg",
                  //                                 style:
                  //                                     blackTextStyle.copyWith(
                  //                                         fontWeight:
                  //                                             FontWeight.w600),
                  //                               )
                  //                             ],
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Divider(
                  //                             color: greyColor,
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Text(
                  //                                 "Lokasi",
                  //                                 style: blackTextStyle,
                  //                               ),
                  //                               Text(
                  //                                 "${detailTransaksi.location}",
                  //                                 style:
                  //                                     blackTextStyle.copyWith(
                  //                                         fontWeight:
                  //                                             FontWeight.w600),
                  //                               )
                  //                             ],
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Divider(
                  //                             color: greyColor,
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Text(
                  //                                 "Sistem",
                  //                                 style: blackTextStyle,
                  //                               ),
                  //                               Text(
                  //                                 "${detailTransaksi.retrievalSystem}",
                  //                                 style:
                  //                                     blackTextStyle.copyWith(
                  //                                         fontWeight:
                  //                                             FontWeight.w600),
                  //                               )
                  //                             ],
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Divider(
                  //                             color: greyColor,
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Text(
                  //                                 "Total Pendapatan",
                  //                                 style: blackTextStyle,
                  //                               ),
                  //                               Text(
                  //                                 "+Rp. ${detailTransaksi.totalPrice}",
                  //                                 style:
                  //                                     blackTextStyle.copyWith(
                  //                                         fontWeight:
                  //                                             FontWeight.w600),
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ]),
                  //                       ),
                  //                     ]),
                  //               ));
                  //         }
                  //         if (state is DetailTransaksiBuyerFailed) {
                  //           return Center(
                  //             child: Text(
                  //               "Terjadi Kesalahan :(",
                  //               style: blackTextStyle.copyWith(
                  //                   fontSize: 16, fontWeight: semiBold),
                  //             ),
                  //           );
                  //         }
                  //         return Container();
                  //       },
                  //     ),
                  //   )
                  // ]
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
