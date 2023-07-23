import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salvapp_amcc/UI/pages/topup_success.dart';
import 'package:salvapp_amcc/blocs/topup/topup_bloc.dart';
import 'package:salvapp_amcc/models/topup_form_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webview_flutter_android/webview_flutter_android.dart';

import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../blocs/shared/shared_methods.dart';

class WebviewMidtransPage extends StatefulWidget {
  final TopupFormModel? topupFormModel;
  static const routeName = "/webviewmidtrans";
  WebviewMidtransPage({super.key, this.topupFormModel});

  @override
  State<WebviewMidtransPage> createState() => _WebviewMidtransPageState();
}

class _WebviewMidtransPageState extends State<WebviewMidtransPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  late final PlatformWebViewControllerCreationParams params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pembayaran Topup"),
        ),
        body: BlocProvider(
          create: (context) => TopupBloc()
            ..add(TopupGetAmount(topupFormModel: widget.topupFormModel)),
          child: BlocConsumer<TopupBloc, TopupState>(
            listener: (context, state) {
              if (state is TopupFailed) {
                showCustomSnacKbar(context, state.e);
              }
            },
            builder: (context, state) {
              if (state is TopupLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TopupSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                      child: WebViewWidget(
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..setBackgroundColor(const Color(0x00000000))
                      ..setNavigationDelegate(
                        NavigationDelegate(
                          onProgress: (int progress) {
                            // Update loading bar.
                          },
                          onPageStarted: (String url) {},
                          onPageFinished: (String url) {},
                          onWebResourceError: (WebResourceError error) {},
                          onNavigationRequest: (NavigationRequest request) {
                            if (request.url.contains("verifyPaymentPin")) {
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return TopUpSuccessPage();
                                  },
                                ), (route) => false);
                              });
                            }

                            return NavigationDecision.navigate;
                          },
                        ),
                      )
                      ..loadRequest(Uri.parse(
                          "${state.midtransPayment!.actions![1].url}")),
                  )),
                );
              }
              return Container();
            },
          ),
        ));
  }
}
