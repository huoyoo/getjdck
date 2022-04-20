import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于蛋APP"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: const Text("蛋APP，已经将代码开源至github仓库。该APP是为了方便本宝蛋和她的小伙伴自己去通过青龙面板挂载京东账号使用。"),
            ),
            Container(child: const Text("该APP基于flutter开发，如果您感兴趣开源去github仓库拉去代码进行封装APP使用！"),),
            Container(child: const Text("广告：如果您有用到云服务器，请访问火数云 www.huocloud.com"),),
          ],
        )
      ),
    );
  }

}