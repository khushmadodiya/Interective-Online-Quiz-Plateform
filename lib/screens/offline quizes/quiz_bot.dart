import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';




class QuizBot extends StatefulWidget {

  const QuizBot({super.key,});

  @override
  State<QuizBot> createState() => _QuizBotState();
}

class _QuizBotState extends State<QuizBot> {
  double _progress = 0;
  late InAppWebViewController  inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{

        var isLastPage = await inAppWebViewController.canGoBack();

        if(isLastPage){
          inAppWebViewController.goBack();
          return false;
        }

        return true;
      },
      child: Scaffold(


        body:

        Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse('https://mediafiles.botpress.cloud/0acb875b-230e-4424-a348-769d3b0e48a5/webchat/bot.html')
              ),
              onWebViewCreated: (InAppWebViewController controller){
                inAppWebViewController = controller;
              },
              onProgressChanged: (InAppWebViewController controller , int progress){
                setState(() {
                  _progress = progress / 100;
                });
              },
              initialOptions: InAppWebViewGroupOptions(
                android: AndroidInAppWebViewOptions(
                  disableDefaultErrorPage: false,
                  // useHybridComposition: true,
                  supportMultipleWindows: false,
                  cacheMode: AndroidCacheMode.LOAD_DEFAULT,
                ),
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  mediaPlaybackRequiresUserGesture: false,
                  // debuggingEnabled: true,
                ),
              ),

            ),

            _progress < 1 ? Container(
              child: LinearProgressIndicator(
                value: _progress,
              ),
            ):SizedBox()
          ],
        ),
      ),
    );
  }
}