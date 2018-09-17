import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter_app/classify/classify_demo.dart';
import 'package:gank_flutter_app/const.dart' as Const;

void main() {
  debugInstrumentationEnabled = true;
  MaterialPageRoute.debugEnableFadingRoutes = true;

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int current = 0;
  List<Widget> widgets = [
    new Container(),
    new ClassifyDemo(category: Const.Const.classification),
    new Container(),
    new Container()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgets.add(new Container());
    widgets.add(new ClassifyDemo(category: Const.Const.classification));
    widgets.add(new Container());
    widgets.add(new Container());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(child: Container(
              child: widgets[current],
            )),
            BottomNavigationBar(
              items: Const.bottomNavigationBarItems,
              onTap: handleBottomTap,
            )
          ],
        ));
  }

  void handleBottomTap(int index) {
    setState(() {
      current = index;
    });
  }
}
