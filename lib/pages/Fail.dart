import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home.dart';

class FailPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("获取CK失败"),
        centerTitle: true,
      ),
      body:Container(
        margin: EdgeInsets.all(10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              Container(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: SvgPicture.asset("assets/fail.svg"),
                  )
              ),
              SizedBox(height: 30,),
              Container(
                child: const Text("获取CK失败了，点击下面按钮重新获取！"),
              ),
              SizedBox(height: 20,),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyHomePage()
                        ),
                            (route) => route == null
                    );
                  },
                  child: Text("返回首页重新获取"),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

}