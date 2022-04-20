import 'dart:async';
import 'dart:convert';
import 'package:dan/pages/Fail.dart';
import 'package:dan/tool/api.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import 'home.dart';


class WebPage extends StatefulWidget {

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  final cookieManager = WebviewCookieManager();

  @override
  void initState(){
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('获取CK'),
        actions: [
          ElevatedButton(onPressed: () async{
            final cookies = await cookieManager.getCookies("https://m.jd.com");
            TextEditingController _phone = TextEditingController();
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text("提交查询手机号"),
                content: Container(
                    child: TextField(
                      controller: _phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder()
                      )
                    ),
                ),
                actions: [
                  Container(
                    child: ElevatedButton(
                        onPressed: (){
                        SendCK(context, _phone.text, cookies);
                    }, child: Text("提交")),
                  )
                ],
              );
            }
            );
          }, child: Text("登录完成后点击我"))
        ],
    ),
    body: WebView(
    initialUrl: 'https://m.jd.com/',
    javascriptMode: JavascriptMode.unrestricted,
    gestureNavigationEnabled: true,
    onWebViewCreated: (WebViewController webViewController) {
      _controller.complete(webViewController);
    },
    ),
    );
  }
}

Future<void> SendCK(BuildContext context, String phone, List<Cookie> cookies) async{
  String pt_key = '';
  String pt_pin = '';

  for (var item in cookies) {
    if(item.toString().indexOf('pt_key') == 0){
      var key = item.toString().split(';');
      for(int i =0;i<key.length; i++){
        String c = key[i].trim();
        if(c.indexOf('pt_key')==0){
          pt_key = c;
        }
      }
    }
    if(item.toString().indexOf('pt_pin') == 0){
      var key = item.toString().split(';');
      for(int i =0;i<key.length; i++){
        String c = key[i].trim();
        if(c.indexOf('pt_pin')==0){
          pt_pin = c;
        }
      }
    }
  }

  if(pt_key.length == 0 || pt_pin ==0){
    Navigator.pushNamed(context, '/fail');
  }else{
    sendDingDing(phone, pt_key, pt_pin);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage()
        ),
            (route) => route == null
    );
  }

}