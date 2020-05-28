import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:convert';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutterapp/main.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:async';
import 'user.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_json_widget/flutter_json_widget.dart';
import 'dart:math';
import 'dart:developer';

String mainColor = "ffffff00";


class Page3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //final wordP = WordPair.random();

    return MaterialApp(
      title: 'Page3',
      home: RandomWords(),
    );

  }
}


class RandomWordsState extends State<RandomWords>{
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  String _user;
  static List<RadioModel> sampleData = new List<RadioModel>();
  String isSelectedColor = "";
  var key;
  CustomRadio cRadio;
  String currentColor = mainColor;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("RandomWordsState call initState");
  }

  void returnInASec() async{
    await Future.delayed(
      Duration(seconds: 1),
    );
  }


  Future _updateJsonData() async {
    loadJsonAsset();
    cRadio = CustomRadio(sampleData);
    return cRadio;
  }

  Future loadJsonAsset() async {
    String jsonString = await rootBundle.loadString('json/data.json');
    final jsonResponse = json.decode(jsonString);
    debugPrint('getJsonData');
    sampleData
        ..add(new RadioModel(false, jsonResponse['colorName'][0], jsonResponse['colorList'][0]))
        ..add(new RadioModel(false, jsonResponse['colorName'][1], jsonResponse['colorList'][1]))
        ..add(new RadioModel(false, jsonResponse['colorName'][2], jsonResponse['colorList'][2]))
        ..add(new RadioModel(false, jsonResponse['colorName'][2], jsonResponse['colorList'][3]));
//    sampleData.add(new RadioModel(false, jsonResponse['colorName'][1], jsonResponse['colorList'][1]));
//    sampleData.add(new RadioModel(false, jsonResponse['colorName'][2], jsonResponse['colorList'][2]));
//    sampleData.add(new RadioModel(false, jsonResponse['colorName'][3], jsonResponse['colorList'][3]));
  }

  Future _isChangedMainColor() async{
    if(currentColor != mainColor){
      currentColor = mainColor;
      debugPrint('isChangedMainColor: false');
      return false;
    } else {
      debugPrint('isChangedMainColor: true');
      return true;
    }
  }



  @override
  Widget build(BuildContext context){
    debugPrint("build");
    //_updateJsonData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: Center(
        child: Column(
        children: <Widget>[
          Text(
            mainColor,
            style: TextStyle(
//              color: Color(0x55555555),
//              color: Color(int.parse(_user, radix: 16)),
              color: (_user != null) ? Color(int.parse(_user, radix: 16)) : Colors.black,
            ),
          ),

          //Text('$_data'),

          FutureBuilder(
            future: _updateJsonData(),
            builder: (context, future){
              if(!future.hasData){
                return Text('loading');
              }
              return SizedBox(
                height: 300.0,
                width: 200,
                //child: CustomRadio(sampleData),
                child: cRadio,
              );
            },
          ),

//          FutureBuilder(
//            future: _isChangedMainColor(),
//            builder: (context, future){
//              if(currentColor == ''){
//                return Text('null');
//              }
//              return Text('$mainColor');
//            },
//          ),


          Text('$mainColor'),

        ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        //onPressed: ,//_updateJsonData,
        child: Icon(Icons.add),
      ),
    );

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    debugPrint("dispose");
  }



}

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();
}


// ignore: must_be_immutable
class CustomRadio extends StatefulWidget{
  List<RadioModel> item;
  String isSelectedColor = "";

  CustomRadio(this.item);

  @override
  createState(){
    return new CustomRadioState(this.item);
  }
}

class CustomRadioState extends State<CustomRadio>{
  //List<RadioModel> sampleData = new List<RadioModel>();
  //final RadioModel _item;
  List<RadioModel> _item;
  CustomRadioState(this._item);

  String _data = "Load JSON Data";
  String isSelectedColor = "";
  var key;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    debugPrint('makeRadioButton');
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      //itemCount: sampleData.length,
      itemCount: _item.length,
      itemBuilder: (BuildContext context, int index){
        return InkWell(
          //highlightColor: Colors.red,
          //splashColor: Colors.blueAccent,
          onTap: (){
            setState(() {
              _item.forEach((element) => element.isSelected = false);
              _item[index].isSelected = true;
              isSelectedColor = _item[index].buttonText;
              mainColor = _item[index].buttonText;
              debugPrint("isTapedRadioItem");
              debugPrint('$mainColor');
            });
          },
          //child: new RadioItem(sampleData[index]),
          child: new RadioItem(_item[index]),
        );
      },
    );
  }
//  Widget build(BuildContext context){
//    debugPrint('makeRadioButton');
//    return Column(
//
//
//      children: <Widget>[
//        ListView.builder(
//          shrinkWrap: true,
//          scrollDirection: Axis.horizontal,
//          //itemCount: sampleData.length,
//          itemCount: _item.length,
//          itemBuilder: (BuildContext context, int index){
//            return InkWell(
//              //highlightColor: Colors.red,
//              //splashColor: Colors.blueAccent,
//              onTap: (){
//                setState(() {
//                  _item.forEach((element) => element.isSelected = false);
//                  _item[index].isSelected = true;
//                  isSelectedColor = _item[index].buttonText;
//                  mainColor = _item[index].buttonText;
//                  debugPrint("isTapedRadioItem");
//                  debugPrint('$mainColor');
//                });
//              },
//              //child: new RadioItem(sampleData[index]),
//              child: new RadioItem(_item[index]),
//            );
//          },
//        ),
//
//        //Text(mainColor),
//      ],
//    );
//  }

}

class RadioItem extends StatelessWidget{
  final RadioModel _item;
  RadioItem(this._item);

  @override
  Widget build(BuildContext context){
    return Center(
      child: Container(
        height: 50.0,
        width: 50.0,
        child: new Center(
          child: new Text(
            _item.buttonText,
            style: new TextStyle(
                color: _item.isSelected ? Colors.white : Colors.black,
                //fontWeight: FontWeight.bold,
                fontSize: 18.0
            ),
          ),
        ),
        decoration: new BoxDecoration(
          color: _item.isSelected
              ? Color(int.parse(_item.selectedColor, radix: 16))
              : Colors.transparent,
          border: new Border.all(
              width: 1.0,
              color: _item.isSelected
                  ? Colors.blueAccent
                  : Colors.grey),
          borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
        ),
      ),
    );
  }
}

class RadioModel{
  bool isSelected;
  final String buttonText;
  final String selectedColor;

  RadioModel(this.isSelected, this.buttonText, this.selectedColor);
}








