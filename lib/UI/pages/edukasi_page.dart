import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/edukasi/edukasi_bloc.dart';
import '../../common/common.dart';
import '../widgets/list_edukasi_widget.dart';
import 'detail_edukasi_page.dart';

class EdukasiPage extends StatefulWidget {
  static const routeName = '/edukasi';
  const EdukasiPage({super.key});

  @override
  State<EdukasiPage> createState() => _EdukasiPageState();
}

class _EdukasiPageState extends State<EdukasiPage> {
  dynamic stateEdukasi;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final edukasiState = context.read<EdukasiBloc>().state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Container(
            color: greenColor,
            height: 153,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Edukasi Limbah Makanan",
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
                            "Sisa limbah makanan memiliki banyak manfaat. \nSimaklah edukasi yang disediakan untuk \nmengetahui apa yang dapat dilakukan terhadap \nlimbah makanan.",
                            style: whiteTextStyle.copyWith(
                                fontSize: 12, fontWeight: light),
                          )
                        ],
                      ),
                    ],
                  )),
            ]),
          ),
          BlocBuilder<EdukasiBloc, EdukasiState>(
            builder: (context, state) {
              if (state is EdukasiLoading) {
                return Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(children: [
                    Center(
                      child: CircularProgressIndicator(color: greenColor),
                    )
                  ]),
                );
              }
              if (state is EdukasiSuccess) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.edukasi!.data.length,
                  itemBuilder: (context, index) {
                    var edukasi = state.edukasi!.data[index];
                    return ListEdukasi(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DetailEdukasiPage(
                              edukasiId: edukasi.id,
                            );
                          },
                        ));
                      },
                      thumbnail: "assets/image/image_example_edukasipng.png",
                      namaTutorial: edukasi.title,
                      durasiVideo: 15,
                      tipeLimbah: edukasi.category,
                    );
                  },
                );
              }
              if (state is EdukasiFailed) {
                return Center(
                  child: Text(
                    "${state.e.toString()}",
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                );
              }
              return Container();
            },
          ),
        ]),
      ),
    );
  }
}
