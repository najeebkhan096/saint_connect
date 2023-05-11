//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class SaintWebView extends StatefulWidget {
//   static const routename="SaintWebView";
//
//   @override
//   State<SaintWebView> createState() => _SaintWebViewState();
// }
//
// class _SaintWebViewState extends State<SaintWebView> {
//   String ? url;
//   @override
//   Widget build(BuildContext context) {
//     url=ModalRoute.of(context)!.settings.arguments as String;
//     return  WebView(
//       onPageFinished: (value){
//         print("onPageFinished value is "+value.toString());
//
//       },
//       onPageStarted: (value){
//
//
//       },
//       onWebViewCreated: (value){
//         print("onWebViewCreated value is "+value.toString());
//       },
//       onProgress: (value){
//         print("onProgress value is "+value.toString());
//       },
//       javascriptMode: JavascriptMode.unrestricted,
//       initialUrl: url,
//     );
//   }
// }
