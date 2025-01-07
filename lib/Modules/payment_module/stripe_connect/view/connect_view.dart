import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ConnectView extends StatefulWidget {

  final String url;
  final void Function(String? url)? onUrlChanged;
  final void Function(String message)? onMessage;
  const ConnectView({super.key,required this.url,this.onUrlChanged,this.onMessage,});

  @override
  State<ConnectView> createState() => _ConnectViewState();
}

class _ConnectViewState extends State<ConnectView> {

  late WebViewController webViewController;

  @override
  void initState() {

/*    late  final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }*/

    webViewController = WebViewController()

      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.whiteText)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print("page progress: $progress");
          },
          onPageStarted: (String url) {
            print("onPageStarted: $url");
          },
          onPageFinished: (String url) {
            print("onPageFinished: $url");
          },
          onWebResourceError: (WebResourceError error) {
            print("resource error: $error");
          },
          onNavigationRequest: (NavigationRequest request) {
            print("url to switch: ${request.url}");
            widget.onUrlChanged?.call(request.url);
            return NavigationDecision.navigate;
          },

        ),
      )
      ..addJavaScriptChannel("PartyLux", onMessageReceived: (val){
        try {
          print("val is successHandler: ${val.message}");
          widget.onMessage?.call(val.message);
        }
        catch(ex){
          print("exception: $ex");
        }
      })
      ..loadRequest(Uri.parse(widget.url));


    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        isBodyPadding: false,
        isVertPadding: false,
        isLeftAlign: false,
        //appBarTitle: AppStrings.addCard,
        showBackBtn: true,

        appbarColor: AppColors.midGrey,
        body: Column(
          children: [
            Expanded(child: WebViewWidget(controller: webViewController)),
/*            AppButton.mainButton(
              context,
              text: "Trigger",
              buttonColor: AppColors.primary,
              onPressed: () {
                //webViewController.runJavaScript("window.webkit.messageHandlers.send_userid.postMessage('userId');")
               // webViewController.runJavaScript("window.alert('Hello! I am an alert box!');");
              //  webViewController.runJavaScript("window.webkit.messageHandlers.successHandler.postMessage('userId');");
                webViewController.runJavaScript("successHandler.postMessage('receive userId');");
                },
            )*/
          ],
        ),
    );
  }
}
