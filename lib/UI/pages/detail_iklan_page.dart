import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:salvapp_amcc/blocs/transaksi/transaksi_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/iklan/iklan_bloc.dart';
import '../../blocs/shared/shared_methods.dart';
import '../../common/common.dart';
import '../../models/jual_limbah_form_model.dart';
import '../../models/user_model.dart';
import '../widgets/buttons.dart';
import 'form_jual_limbah_page.dart';
import 'holder_page.dart';
import 'jual_limbah_success_page.dart';

class DetailIklanPage extends StatefulWidget {
  final String? advertisementId;
  DetailIklanPage({super.key, this.advertisementId});
  static const routeName = '/detailiklan';

  @override
  State<DetailIklanPage> createState() => _DetailIklanPageState();
}

class _DetailIklanPageState extends State<DetailIklanPage> {
  @override
  dynamic userId;
  dynamic userType;
  JualLimbahForm? jualLimbahForm;

  dynamic penghasilanValue = "";

  final TextEditingController beratLimbahController =
      TextEditingController(text: '');

  void initState() {
    // TODO: implement initState

    super.initState();
    final authState = context.read<AuthBloc>().state;

    print("ID : ${widget.advertisementId}");

    if (authState is AuthSuccess) {
      userType = authState.user!.type;
      userId = authState.user!.id;
    }
  }

  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: userType == 2
              ? Text("Detail Iklan")
              : Text(
                  "Buat Penawaran",
                  style: whiteTextStyle.copyWith(fontWeight: regular),
                ),
          backgroundColor: greenColor,
          iconTheme: IconThemeData(color: whiteColor),
        ),
        body: userType == 2
            ? BlocProvider(
                create: (context) => IklanBloc()
                  ..add(IklanGetDetailBuyer(widget.advertisementId)),
                child: BlocConsumer<IklanBloc, IklanState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is IklanFailed) {
                      showCustomSnacKbar(context, state.e);
                    }
                  },
                  builder: (context, state) {
                    if (state is IklanLoading) {
                      return Container(
                          child: Center(
                        child: CircularProgressIndicator(color: greenColor),
                      ));
                    }
                    if (state is IklanBuyerGetDetailSuccess) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 36, vertical: 14),
                        child: Container(
                          child: CustomScrollView(
                            slivers: [
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: Column(children: [
                                  //Only for Mahasiswa

                                  // if pabrik
                                  Flexible(
                                      flex: userType == 2 ? 2 : 4,
                                      child: Container(
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
                                                      BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      blurRadius: 5.0,
                                                      offset: Offset(0,
                                                          3), // changes the position of the shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Flexible(
                                                          child: Wrap(
                                                        children: [
                                                          Text(
                                                            state
                                                                .iklanBuyerDetail!
                                                                .data
                                                                .title,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: blackTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                          )
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Kategori",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        state.iklanBuyerDetail!
                                                            .data.category,
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Ketersediaan Sistem",
                                                        style: blackTextStyle,
                                                      ),
                                                      Flexible(
                                                          child: Container(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [],
                                                        ),
                                                      ))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Lokasi Tujuan",
                                                        style: blackTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Spesifikasi",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        state
                                                            .iklanBuyerDetail!
                                                            .data
                                                            .additionalInformation,
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                              const SizedBox(
                                                height: 14,
                                              ),
                                              Text(
                                                "Ketentuan",
                                                style: blackTextStyle.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
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
                                                        "Berat Minimum",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        "${state.iklanBuyerDetail!.data.minimumWeight.toString()} kg",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Berat Maksimum",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        "${state.iklanBuyerDetail!.data.maximumWeight.toString()} kg",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Divider(
                                                    color: greyColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Pengeluaran",
                                                        style: blackTextStyle,
                                                      ),
                                                      Text(
                                                        "${state.iklanBuyerDetail!.data.price.toString()},- / Kilogram",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              if (widget.advertisementId !=
                                                  "") ...[
                                                Container(
                                                  width: double.infinity,
                                                  height: 160,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Column(children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Tidak ada Batas Kadaluarsa",
                                                          style: blackTextStyle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      semiBold,
                                                                  fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Flexible(
                                                        child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 9),
                                                      child:
                                                          LinearPercentIndicator(
                                                        trailing: Text(
                                                          "${state.iklanBuyerDetail!.data.maximumWeight.toString()} Kg",
                                                          style: blackTextStyle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      semiBold,
                                                                  fontSize: 15),
                                                        ),
                                                        lineHeight: 11,
                                                        percent: state
                                                                .iklanBuyerDetail!
                                                                .data
                                                                .ongoingWeight /
                                                            state
                                                                .iklanBuyerDetail!
                                                                .data
                                                                .requestedWeight,
                                                        animation: true,
                                                        progressColor:
                                                            Colors.yellow,
                                                        backgroundColor:
                                                            greyColor,
                                                        barRadius:
                                                            Radius.circular(8),
                                                      ),
                                                    )),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              "Dibuat: 11 Februari 2021",
                                                              style: blackTextStyle
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          medium,
                                                                      fontSize:
                                                                          9),
                                                            )
                                                          ]),
                                                    ))
                                                  ]),
                                                )
                                              ]
                                            ]),
                                      )),
                                ]),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              )
            : BlocProvider(
                create: (context) => IklanBloc()
                  ..add(IklanGetDetailSeller(widget.advertisementId)),
                child: BlocConsumer<IklanBloc, IklanState>(
                  listener: (context, state) {
                    if (state is IklanFailed) {
                      showCustomSnacKbar(context, state.e);
                    }
                  },
                  builder: (context, state) {
                    if (state is IklanLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: greenColor,
                        ),
                      );
                    }
                    if (state is IklanSellerGetDetailSuccess) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 36, vertical: 24),
                        child: Container(
                          child: CustomScrollView(
                            slivers: [
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: Column(children: [
                                  //Only for Mahasiswa
                                  Flexible(
                                      child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                "${state.iklanSellerDetail!.data.ongoingWeight.toString()}",
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
                                                                  " / ${state.iklanSellerDetail!.data.requestedWeight.toString()}",
                                                                  style: blackTextStyle
                                                                      .copyWith(
                                                                          fontSize:
                                                                              18),
                                                                ),
                                                                Text(
                                                                  "Kg",
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
                                          margin:
                                              const EdgeInsets.only(left: 9),
                                          child: LinearPercentIndicator(
                                            lineHeight: 27,
                                            percent: state.iklanSellerDetail!
                                                    .data.ongoingWeight /
                                                state.iklanSellerDetail!.data
                                                    .requestedWeight,
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
                                                "0 Kg",
                                                style: blueTextStyle.copyWith(
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                "${state.iklanSellerDetail!.data.requestedWeight.toString()}Kg",
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
                                                    state.iklanSellerDetail!
                                                        .data.title,
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                regular),
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
                                                  state.iklanSellerDetail!.data
                                                      .category,
                                                  style: greyTextStyle.copyWith(
                                                      fontWeight: regular),
                                                ))
                                              ],
                                            )
                                          ]),
                                        )
                                      ],
                                    ),
                                  )),

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
                                            height: 16,
                                          ),
                                          Wrap(
                                            children: [
                                              state.iklanSellerDetail!.data
                                                          .additionalInformation ==
                                                      ""
                                                  ? Text("-",
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontWeight:
                                                                  semiBold,
                                                              fontSize: 14))
                                                  : Text(
                                                      "${state.iklanSellerDetail!.data.additionalInformation}",
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontWeight:
                                                                  semiBold,
                                                              fontSize: 14),
                                                    )
                                            ],
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
                                      Text("Ketentuan Limbah"),
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 17, vertical: 16),
                                            decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Column(children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Berat Minimum",
                                                    style: blackTextStyle,
                                                  ),
                                                  Text(
                                                    "${state.iklanSellerDetail!.data.minimumWeight.toString()} kg",
                                                    style:
                                                        blackTextStyle.copyWith(
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
                                                  Text(
                                                    "Berat Maksimum",
                                                    style: blackTextStyle,
                                                  ),
                                                  Text(
                                                    "${state.iklanSellerDetail!.data.maximumWeight.toString()} kg",
                                                    style:
                                                        blackTextStyle.copyWith(
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
                                                  Text(
                                                    userType == 3
                                                        ? "Pengeluaran"
                                                        : "Pendapatan",
                                                    style: blackTextStyle,
                                                  ),
                                                  Text(
                                                    "+Rp.${state.iklanSellerDetail!.data.price},- / Kilogram",
                                                    style:
                                                        blackTextStyle.copyWith(
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Berat Limbah yang Dibutuhkan",
                                        style: blackTextStyle.copyWith(
                                            fontWeight: regular, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        penghasilanValue =
                                            beratLimbahController.text;
                                      });
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.number,
                                    controller: beratLimbahController,
                                    decoration: InputDecoration(
                                        suffix: Text(
                                          "/Kilogram",
                                          style: blackTextStyle.copyWith(
                                            fontWeight: semiBold,
                                          ),
                                        ),
                                        hintText: "Berat",
                                        contentPadding:
                                            const EdgeInsets.all(12),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                  ),

                                  const SizedBox(
                                    height: 59,
                                  ),

                                  BlocProvider(
                                    create: (context) => TransaksiBloc(),
                                    child: BlocConsumer<TransaksiBloc,
                                            TransaksiState>(
                                        listener: (context, state) {
                                      // TODO: implement listener
                                      if (state is TransaksiFailed) {
                                        showCustomSnacKbar(context, state.e);
                                      }
                                      if (state is createTransaksiSuccess) {
                                        Navigator.pushNamed(context,
                                            JualLimbahSuccessPage.routeName);
                                      }
                                    }, builder: (context, state) {
                                      if (state is TransaksiLoading) {
                                        return Center(
                                          child: LoadingAnimationWidget
                                              .twistingDots(
                                            leftDotColor:
                                                greenColor,
                                            rightDotColor:
                                                greenColor,
                                            size: 40,
                                          ),
                                        );
                                      }
                                      return CustomFilledButton(
                                        width: double.infinity,
                                        title: "Buat Penawaran",
                                        onPressed: () {
                                          JualLimbahForm jualLimbahForm =
                                              JualLimbahForm(
                                                  userId: userId,
                                                  advertisementId:
                                                      widget.advertisementId!,
                                                  weight: int.parse(
                                                      penghasilanValue),
                                                  location: "",
                                                  image: "");

                                          context.read<TransaksiBloc>().add(
                                              CreateTransaksiSeller(
                                                  jualLimbahForm));
                                        },
                                      );
                                    }),
                                  ),

                                  if (userType == 2) ...[
                                    Expanded(
                                        child: Container(
                                      child: Column(children: [
                                        Flexible(
                                            child: Container(
                                                child: Column(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/image/image_details_iklan_pabrik.svg"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Berlangsung"),
                                                Text("Selesai"),
                                                Text("Dibatalkan")
                                              ],
                                            )
                                          ],
                                        ))),
                                        Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Column(children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Tidak ada Batas Kadaluarsa",
                                                          style: blackTextStyle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      semiBold,
                                                                  fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Flexible(
                                                        child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 9),
                                                      child:
                                                          LinearPercentIndicator(
                                                        trailing: Text(
                                                          "Kg",
                                                          style: blackTextStyle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      semiBold,
                                                                  fontSize: 15),
                                                        ),
                                                        lineHeight: 11,
                                                        percent: state
                                                                .iklanSellerDetail!
                                                                .data
                                                                .ongoingWeight /
                                                            state
                                                                .iklanSellerDetail!
                                                                .data
                                                                .requestedWeight,
                                                        animation: true,
                                                        progressColor:
                                                            blueColor,
                                                        backgroundColor:
                                                            greyColor,
                                                        barRadius:
                                                            Radius.circular(8),
                                                      ),
                                                    )),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors.red
                                                                        .shade900),
                                                        onPressed: () {},
                                                        child: Text(
                                                          "Batalkan Iklan",
                                                        )),
                                                    Expanded(
                                                        child: Container(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              "Dibuat: 11 Februari 2021",
                                                              style: blackTextStyle
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          medium,
                                                                      fontSize:
                                                                          9),
                                                            )
                                                          ]),
                                                    ))
                                                  ]),
                                                ))
                                              ],
                                            )),
                                      ]),
                                    )),
                                  ]
                                ]),
                              )
                            ],
                          ),
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ));
  }
}
