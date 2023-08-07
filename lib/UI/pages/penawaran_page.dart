import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salvapp_amcc/common/common.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/transaksi/transaksi_bloc.dart';
import '../widgets/list_penawaran_widget.dart';
import 'detail_penawaran_page.dart';

class PenawaranPage extends StatefulWidget {
  static const routeName = '/penawaran';
  const PenawaranPage({super.key});

  @override
  State<PenawaranPage> createState() => _PenawaranPageState();
}

class _PenawaranPageState extends State<PenawaranPage> {
  dynamic userId;
  dynamic userType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthSuccess) {
      userType = authState.user!.type;
      userId = authState.user!.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              color: greenColor,
              height: 118,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Riwayat Penawaran",
                                  style: whiteTextStyle.copyWith(
                                      fontSize: 20, fontWeight: regular),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Lihat status penawaran anda \ndapat ditolak, ataupun diterima",
                                  style: whiteTextStyle.copyWith(
                                      fontSize: 12, fontWeight: regular),
                                )
                              ],
                            ),
                          ],
                        )),
                  ]),
            ),

            //TODO: UI for buyers
            if (userType == 2) ...[
              BlocProvider(
                create: (context) =>
                    TransaksiBloc()..add(TransaksiGetAllBuyer(userId)),
                child: BlocBuilder<TransaksiBloc, TransaksiState>(
                  builder: (context, state) {
                    if (state is TransaksiLoading) {
                      return Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: Center(
                            child: CircularProgressIndicator(color: greenColor),
                          ));
                    }
                    if (state is TransaksiBuyerGetSuccess) {
                      return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 26),
                          shrinkWrap: true,
                          itemCount: state.transaksiBuyer!.data.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var transaksi = state.transaksiBuyer!.data[index];

                            return ListPenawaran(
                              image: transaksi.image,
                              namaLimbah: transaksi.title,
                              totalPrice: "+${transaksi.weight} kg",
                              statusPenawaran: transaksi.status == "0"
                                  ? "Menunggu Konfirmasi"
                                  : transaksi.status == "1"
                                      ? "Sedang Berlangsung"
                                      : transaksi.status == "2"
                                          ? "Selesai"
                                          : transaksi.status == "3"
                                              ? "Ditolak"
                                              : "Dibatalkan",
                              username: transaksi.user,
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return DetailPenawaranPage(
                                    statusPenawaran:
                                        transaksi.status.toString(),
                                    transactionId: transaksi.id,
                                  );
                                })).then((value) {
                                  setState(() {});
                                });
                              },
                            );
                          });
                    }
                    if (state is TransaksiFailed) {
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
              )
            ]

            // TODO: UI for sellers
            else if (userType == 3) ...[
              BlocProvider(
                create: (context) =>
                    TransaksiBloc()..add(TransaksiGetAllSeller(userId)),
                child: BlocBuilder<TransaksiBloc, TransaksiState>(
                  builder: (context, state) {
                    if (state is TransaksiLoading) {
                      return Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: Center(
                            child: CircularProgressIndicator(color: greenColor),
                          ));
                    }
                    if (state is TransaksiSellerGetSuccess) {
                      return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 26),
                          shrinkWrap: true,
                          itemCount: state.transaksiSeller!.data.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (content, index) {
                            var transaksi = state.transaksiSeller!.data[index];
                            //kirim data ke detail untuk statusnya
                            var statusType = transaksi.status;
                            return ListPenawaran(
                              image: transaksi.image,
                              namaLimbah: transaksi.title,
                              totalPrice: "Rp.${transaksi.totalPrice}",
                              statusPenawaran: transaksi.status == "0"
                                  ? "Menunggu Konfirmasi"
                                  : transaksi.status == "1"
                                      ? "Sedang Berlangsung"
                                      : transaksi.status == "2"
                                          ? "Diterima"
                                          : transaksi.status == "3"
                                              ? "Ditolak"
                                              : "Dibatalkan",
                              username: transaksi.user,
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return DetailPenawaranPage(
                                    transactionId: transaksi.id,
                                    statusPenawaran: statusType,
                                  );
                                })).then((value) {
                                  setState(() {});
                                });
                              },
                            );
                          });
                    }
                    if (state is TransaksiFailed) {
                      print("yes");
                      return Container(
                          child: Column(
                        children: [
                          Image.asset("assets/image/image_penawaran_empty.png"),
                          Text(
                            "Data Penawaran kamu kosong",
                            style: blackTextStyle.copyWith(fontSize: 16),
                          )
                        ],
                      ));
                    }
                    return Container();
                  },
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
