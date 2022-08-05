// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleNews extends StatefulWidget {
  const ArticleNews({
    Key? key,
    required this.newsUrl,
  }) : super(key: key);
   final String newsUrl;

  @override
  State<ArticleNews> createState() => _ArticleNewsState();
}

class _ArticleNewsState extends State<ArticleNews> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  late bool _isLoadingPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("News"),
      ),
      body: Stack(children: [
        WebView(
          initialUrl: widget.newsUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            _completer.complete(controller);
          },
          onPageFinished: (url) => setState(() {
            _isLoadingPage = false;
          }),
        ),
        if (_isLoadingPage)
          Container(
            alignment: FractionalOffset.center,
            child: const CircularProgressIndicator(
              backgroundColor: Colors.amber,
            ),
          )
        else
          Container(),
      ]),
    );
  }

  @override
  void initState() {
    _isLoadingPage = true;
    super.initState();
  }
}
