import 'package:dan/pages/Fail.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/about.dart';
import 'pages/web.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final routes = {
    '/':(context) => MyHomePage(),
    '/about':(context) => AboutPage(),
    '/web':(context) => WebPage(),
    '/fail':(context) => FailPage(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '蛋Dan',
      // home: const MyHomePage(title: '蛋APP'),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings){
        final String? name = settings.name;
        final Function? pageContentBuilder = routes[name];
        if (pageContentBuilder != null){
          if(settings.arguments != null){
            final Route route = MaterialPageRoute(builder: (context)=>pageContentBuilder(context, arguments: settings.arguments));
            return route;
          }else{
            final Route route = MaterialPageRoute(
                builder: (context) =>
                    pageContentBuilder(context));
            return route;
          }
        }
      },
      initialRoute: '/',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}
