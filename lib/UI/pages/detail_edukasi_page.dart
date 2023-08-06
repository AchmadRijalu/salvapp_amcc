import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../blocs/edukasi/edukasi_bloc.dart';
import '../../common/common.dart';

class DetailEdukasiPage extends StatefulWidget {
  final String? edukasiId;
  final String? idVideo;

  static const routeName = '/detailedukasi';

  const DetailEdukasiPage({super.key, this.idVideo, this.edukasiId});

  @override
  State<DetailEdukasiPage> createState() => _DetailEdukasiPageState();
}

class _DetailEdukasiPageState extends State<DetailEdukasiPage> {
  int currentIndex = 0;
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: BlocProvider(
            create: (context) =>
                EdukasiBloc()..add(EdukasiGetDetail(widget.edukasiId)),
            child: BlocBuilder<EdukasiBloc, EdukasiState>(
              builder: (context, state) {
                if (state is EdukasiLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: greenColor),
                  );
                }
                if (state is EdukasiFailed) {
                  return Center(
                    child: Text(state.e.toString()),
                  );
                }
                if (state is EdukasiGetDetailSuccess) {
                  return Container(
                      child: CarouselSlider.builder(
                          carouselController: carouselController,
                          itemCount: state.edukasiDetail!.data.children!.length,
                          itemBuilder: (context, index, realIndex) {
                            var edukasiIndex =
                                state.edukasiDetail!.data.children![index];
                            // print(edukasiIndex.title);
                            var videoId = edukasiIndex.video;

                            String? getVideoID(String? url) {
                              try {
                                var video = YoutubePlayer.convertUrlToId(url!);
                                return video!;
                              } on Exception catch (exception) {
                                print(exception);
                              } catch (e) {
                                rethrow;
                              }
                            }

                            final YoutubePlayerController _videoController =
                                YoutubePlayerController(
                                    initialVideoId: getVideoID(videoId)!,
                                    flags: const YoutubePlayerFlags(
                                        autoPlay: false, mute: false));

                            return Container(
                                child: Column(
                              children: [
                                Stack(
                                  children: [
                                    YoutubePlayer(
                                      controller: _videoController,
                                      liveUIColor: greenColor,
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 15,
                                      child: CircleAvatar(
                                        backgroundColor: greenColor,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            if (currentIndex + 1 ==
                                                state.edukasiDetail!.data
                                                    .children!.length) {
                                              setState(() {
                                                carouselController
                                                    .previousPage();
                                              });
                                            } else if (currentIndex == 0) {
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            } else {
                                              carouselController.previousPage();
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                    child: CustomScrollView(
                                  slivers: [
                                    SliverFillRemaining(
                                      hasScrollBody: false,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28),
                                        child: Column(
                                          children: [
                                            Flexible(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                // Text(
                                                //   "${edukasiIndex.duration.toString()} menit",
                                                //   style: greyTextStyle.copyWith(
                                                //       fontSize: 8),
                                                // )
                                              ],
                                            )),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: Wrap(
                                                children: [
                                                  Text(
                                                    "${edukasiIndex.title}",
                                                    style:
                                                        blueTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                regular),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${currentIndex + 1}/ ${state.edukasiDetail!.data.children!.length} Step",
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontSize: 12,
                                                          fontWeight: regular),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              child: Wrap(
                                                children: [
                                                  Text(
                                                    "${edukasiIndex.content}",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 12,
                                                            fontWeight: light),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 22,
                                            ),
                                            Divider(
                                              color: greenColor,
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Persiapan",
                                                  style: blueTextStyle.copyWith(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Flexible(
                                                child: Wrap(
                                              children: [
                                                Text(
                                                  "${edukasiIndex.preparation}",
                                                  style: greyTextStyle.copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                )
                                              ],
                                            )),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Tahapan",
                                                  style: blueTextStyle.copyWith(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Wrap(
                                              children: [
                                                Text(
                                                  "${edukasiIndex.implementation}",
                                                  style: greyTextStyle.copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 26,
                                            ),
                                            Container(
                                                child: Column(
                                              crossAxisAlignment: currentIndex +
                                                          1 !=
                                                      state.edukasiDetail!.data
                                                          .children!.length
                                                  ? CrossAxisAlignment.end
                                                  : CrossAxisAlignment.start,
                                              children: [
                                                currentIndex + 1 !=
                                                        state
                                                            .edukasiDetail!
                                                            .data
                                                            .children!
                                                            .length
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            right: 10, left: 5),
                                                        child: Row(
                                                          mainAxisAlignment: currentIndex +
                                                                      1 !=
                                                                  state
                                                                      .edukasiDetail!
                                                                      .data
                                                                      .children!
                                                                      .length
                                                              ? MainAxisAlignment
                                                                  .end
                                                              : MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            SizedBox(
                                                              width: 150,
                                                              child:
                                                                  ElevatedButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        )),
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all(greenColor),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        if (currentIndex +
                                                                                1 ==
                                                                            state.edukasiDetail!.data.children!.length) {
                                                                          setState(
                                                                              () {
                                                                            carouselController.previousPage();
                                                                          });
                                                                        } else {
                                                                          setState(
                                                                              () {
                                                                            carouselController.nextPage();
                                                                          });
                                                                        }
                                                                      },
                                                                      child: Text(
                                                                          "Selanjutnya")),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            ))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                              ],
                            ));
                          },
                          options: CarouselOptions(
                              height: double.infinity,
                              viewportFraction: 1,
                              enableInfiniteScroll: false,
                              onPageChanged: ((index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              }))));
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
