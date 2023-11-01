import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PodcastsRadiofobiaScreen extends StatefulWidget {
  const PodcastsRadiofobiaScreen({Key? key}) : super(key: key);

  @override
  State<PodcastsRadiofobiaScreen> createState() =>
      _PodcastsRadiofobiaScreenState();
}

class _PodcastsRadiofobiaScreenState extends State<PodcastsRadiofobiaScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
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
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
            'https://radiofobia.com.br/podcast/show/radiofobia-classics/'),
      );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: WebViewWidget(
          controller: controller,
        ),
      );
}
