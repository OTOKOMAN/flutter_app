import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';
import 'page2.dart';
import 'page3.dart';
import 'package:english_words/english_words.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'user.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}


enum ColorTest { red, green, blue }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
//      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int listCount11 = 0;



//  final json2='{"hello":"world"}';
//  static var userMap = json.decode(json2);
//  var user = User.fromJson(userMap);
  String _data = "Load JSON Data";

//  void _updateJsonData(){
//    setState(() {
//      loadJsonAsset();
//    });
//  }
//
//  Future<void> loadJsonAsset() async {
//    _data = "";
//    String loadData = await rootBundle.loadString('json/data.json');
//    final jsonResponse = json.decode(loadData);
//    jsonResponse.forEach((key, value) => _data = _data + '$key : $value \x0A');
//  }



  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Header(),

      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:',),
            Text('$_counter', style: Theme.of(context).textTheme.headline4,),
//            Text('${user.toJson()}'),

            SizedBox(
              width: 100.0,
              height: 50.0,
              child: RaisedButton(
                child: Text('go to page2',),
                onPressed: (){Navigator.of(context).push(_createRoute());},
              ),
            ),

            SizedBox(
              width: 100,
              height: 50,
              child: RaisedButton(
//                child: Text('$listCount11'),
                child: Text('$mainColor'),
                onPressed: (){Navigator.of(context).push(_createRoute3());},
              ),
            ),

            SizedBox(
              width: 200.0,
              height: 200.0,
              child: GridView.count(
                childAspectRatio: 1.0,
                crossAxisCount: 4,
                children: List.generate(16, (index){
                  listCount11 = index;
                  return Center(
                    child: TestButton(index),
                  );
                }),
              ),
            ),

//            SizedBox(
//              width: 500,
//              height: 100,
//              child: Center(
//                child: CustomRadio(),
//              ),
//            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.

      bottomNavigationBar: Footer(),

    );
  }

}

Route _createRoute(){
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child){
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve:curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute3(){
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page3(),
    transitionsBuilder: (context, animation, secondaryAnimation, child){
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve:curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}


class TestButton extends StatefulWidget{
  const TestButton(int index);

  @override
  _TestButton createState() => _TestButton();
}



class _TestButton extends State<TestButton>{
  int count = 0;
  bool testButtonBool = true;
  MaterialColor test = Colors.green;

  @override
  Widget build(BuildContext context){
    if(testButtonBool == true){
      test = Colors.red;
    } else {
      test = Colors.blue;
    }

    return SizedBox.expand(
      child: RaisedButton(
        child: Text('$count'),
        color: test,
        shape: Border(
          top: BorderSide(color: Colors.black),
          left: BorderSide(color: Colors.black),
          right: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
        onPressed: (){
          setState(() => testButtonBool = !testButtonBool);
          ++count;
        },
      ),
    );

  }
}




