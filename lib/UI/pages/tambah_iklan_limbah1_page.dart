import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salvapp_amcc/UI/pages/tambah_iklan_limbah2_page.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../blocs/iklan/iklan_bloc.dart';
import '../../blocs/shared/shared_methods.dart';
import '../../common/common.dart';

import '../../models/iklan_form_model.dart';
import '../../models/kategori_limbah_model.dart';
import '../../services/kategori_limbah_services.dart';
import '../widgets/buttons.dart';
import '../widgets/forms.dart';
import 'holder_page.dart';

class TambahIklanLimbah1Page extends StatefulWidget {
  int step;
  static const routeName = '/tambahiklanlimbah1';
  TambahIklanLimbah1Page({super.key, required this.step});

  @override
  State<TambahIklanLimbah1Page> createState() => _TambahIklanLimbah1PageState();
}

class _TambahIklanLimbah1PageState extends State<TambahIklanLimbah1Page> {
  // int step = 1;

  final TextEditingController namaController = TextEditingController(text: '');
  final TextEditingController hargaController = TextEditingController(text: '');
  final TextEditingController beratLimbahDibutuhkanController =
      TextEditingController(text: '');
  final TextEditingController beratLimbahMinimumController =
      TextEditingController(text: '');
  final TextEditingController beratLimbahMaksimumController =
      TextEditingController(text: '');
  final TextEditingController keinginanTambahanController =
      TextEditingController(text: '');

  late Future<KategoriLimbah> provinceList;
  dynamic kategoriLimbah;
  late Future<KategoriLimbah> kategoriLimbahList;
  dynamic sistem;
  dynamic sistemNumber;

  List<String> listKategoriLimbah = ["Buah-buahan", "Sayur-sayuran"];
  List<String> listSistemPengambilan = [
    "Diantar pemilik Limbah",
    "Diambil di pemilik limbah"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    kategoriLimbahList = KategoriLimbahService().getKategoriLimbah();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  bool validate() {
    if (namaController.text.isEmpty ||
        kategoriLimbah == null ||
        hargaController.text.isEmpty ||
        beratLimbahDibutuhkanController.text.isEmpty ||
        beratLimbahMinimumController.text.isEmpty ||
        beratLimbahMaksimumController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Tambah Iklan")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          child: ListView(
              physics: BouncingScrollPhysics(),
              reverse: false,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormField(
                          title: "Nama Iklan",
                          controller: namaController,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Text(
                              "Kategori Limbah",
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          child: FutureBuilder(
                            future: kategoriLimbahList,
                            builder: ((context,
                                AsyncSnapshot<KategoriLimbah> snapshot) {
                              var state = snapshot.connectionState;
                              if (state != ConnectionState.done) {
                                return DropdownButtonFormField(
                                  hint: Text("Tunggu Sebentar.."),
                                  decoration: InputDecoration(
                                      focusColor: greenColor,
                                      contentPadding: const EdgeInsets.all(12),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  items: [],
                                  onChanged: (value) {},
                                );
                              } else {
                                if (snapshot.hasData) {
                                  return DropdownButtonFormField(
                                    hint: kategoriLimbah == null
                                        ? Text("Pilih Kategori Limbah")
                                        : Text(kategoriLimbah.toString()),
                                    value: kategoriLimbah,
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        kategoriLimbah = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        focusColor: greenColor,
                                        contentPadding:
                                            const EdgeInsets.all(12),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    items: snapshot.data!.data.map((val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(
                                          val.name,
                                        ),
                                      );
                                    }).toList(),
                                  );
                                } else if (snapshot.hasError) {
                                  return DropdownButtonFormField(
                                    hint: Text("No Internet"),
                                    decoration: InputDecoration(
                                        focusColor: greenColor,
                                        contentPadding:
                                            const EdgeInsets.all(12),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    items: [],
                                    onChanged: (value) {},
                                  );
                                } else {
                                  return const Material(
                                    child: Text(""),
                                  );
                                }
                              }
                            }),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        //NOTE: EMAIL INPUT
                        CustomFormField(
                          title: "Harga",
                          controller: hargaController,
                          keyBoardType: TextInputType.number,
                          isWeight: true,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        CustomFormField(
                          title: "Berat Limbah yang Dibutuhkan",
                          controller: beratLimbahDibutuhkanController,
                          keyBoardType: TextInputType.number,
                          isWeight: true,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        CustomFormField(
                          title: "Berat Limbah Minimum",
                          controller: beratLimbahMinimumController,
                          keyBoardType: TextInputType.number,
                          isWeight: true,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        //NOTE: EMAIL INPUT
                        CustomFormField(
                          title: "Berat Limbah Maksimum",
                          controller: beratLimbahMaksimumController,
                          keyBoardType: TextInputType.number,
                          isWeight: true,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Text(
                              "Keinginan Tambahan",
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: keinginanTambahanController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 8, //or null
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: greenColor, width: 2.0),
                              ),
                              hintText: "Masukkan keinginan tambahan",
                              contentPadding: const EdgeInsets.all(12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        SizedBox(
                          height: 52,
                        ),

                        BlocProvider(
                          create: (context) => IklanBloc(),
                          child: BlocConsumer<IklanBloc, IklanState>(
                            listener: (context, state) {
                              // TODO: implement listener
                              if (state is IklanFailed) {
                                showCustomSnacKbar(context, state.e);
                              }
                              if (state is IklanAddSuccess) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    HolderPage.routeName, (route) => false);
                              }
                            },
                            builder: (context, state) {
                              if (state is IklanLoading) {
                                return Center(
                                  child: const CircularProgressIndicator(
                                    color: Colors.green,
                                  ),
                                );
                              }
                              return CustomFilledButton(
                                title: "Tambah Iklan",
                                onPressed: () {
                                  if (validate()) {
                                    Alert(
                                      context: context,
                                      type: AlertType.warning,
                                      style: AlertStyle(
                                          titleStyle: blackTextStyle.copyWith(
                                              fontWeight: bold, fontSize: 22)),
                                      title: "Yakin untuk Memulai Iklan?",
                                      desc:
                                          "Iklan yang sudah diiklankan tidak dapat diubah",
                                      buttons: [
                                        DialogButton(
                                          color: redColor,
                                          child: Text(
                                            "Kembali",
                                            style: whiteTextStyle.copyWith(
                                                fontWeight: bold, fontSize: 16),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(
                                              context,
                                            );
                                          },
                                          width: 120,
                                        ),
                                        DialogButton(
                                          color: Colors.green,
                                          child: Text(
                                            "Iklankan",
                                            style: whiteTextStyle.copyWith(
                                                fontWeight: bold, fontSize: 16),
                                          ),
                                          onPressed: () {
                                            context
                                                .read<IklanBloc>()
                                                .add(IklanAddAds(
                                                  TambahIklanForm(
                                                    foodWasteCategoryId:
                                                        kategoriLimbah.id,
                                                    name: namaController.text,
                                                    additionalInformation:
                                                        keinginanTambahanController
                                                            .text,
                                                    price: int.tryParse(
                                                        hargaController.text),
                                                    requestedWeight: int.tryParse(
                                                        beratLimbahDibutuhkanController
                                                            .text),
                                                    minimumWeight: int.tryParse(
                                                        beratLimbahMinimumController
                                                            .text),
                                                    maximumWeight: int.tryParse(
                                                        beratLimbahMaksimumController
                                                            .text),
                                                  ),
                                                ));
                                          },
                                          width: 120,
                                        )
                                      ],
                                    ).show();
                                  } else {
                                    showCustomSnacKbar(context,
                                        "Mohon isi Form Nama Hingga Informasi Berat Maksimum");
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom))
              ]),
        ),
      ),
    );
  }
}
