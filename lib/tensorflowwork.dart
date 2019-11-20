import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imageclassificationapp/RecognizeData.dart';

import 'GenericFunctions.dart';
import 'MyInheritedWidget.dart';
import 'main.dart';

class TensorFlowWork extends StatefulWidget {

  //TensorFlowWork({this.str});
  //final String str;
  @override
  _TensorFlowWorkState createState() {
    return _TensorFlowWorkState(
       // str: this.str
    );
  }
}

class _TensorFlowWorkState extends State<TensorFlowWork> {
  File _image;
  bool _busy = false;
  double _imageHeight;
  double _imageWidth;

  var viewAllStyle = TextStyle(fontSize: 14.0, color: appTheme.primaryColor);

  @override
  Widget build(BuildContext context) {
    debugPrint("Present in build method of TensorFlowWorkState()");

    ///  ******************   First get data from Inherited Widget  and set in below list  ***************   ///
    List<CityCard> cityCards = [
      CityCard("assets/images/athens.jpg","Feb 2019","45", "4299", "3299"),
      //CityCard("assets/images/lasvegas.jpg","Feb 2018","65", "4299", "3299"),
      //CityCard("assets/images/sydney.jpeg","Feb 2017","30", "4299", "3299"),
    ];

    List<Widget> stackChildren = [];
    /*if(GenericFunctions.isDataReceived == true){
      debugPrint('Before getData() function called');
      //List data = GenericFunctions.getData();
      debugPrint('value of data in _TensorFlowWorkState in   build method is  $data');
    }
    else{
      debugPrint('Sorry data is not received yet');
    }*/

    var recognition;


    if(recognition == null){
      debugPrint("recognition == null");
      stackChildren.add(
        Center(child: Text("Currently Detected Items", style: dropdownMenuItemStyle,textAlign: TextAlign.center,)),
        //Padding(
          //padding: const EdgeInsets.symmetric(horizontal: 38.0),
          /*Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Currently Detected Items", style: dropdownMenuItemStyle,textAlign: TextAlign.center,),
              //Text("Confidence", style: viewAllStyle,)
            ],
          ),*/
        //),
      );
      stackChildren.add(
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: cityCards,//cityCards,//cityCards,
          ),
        ),
      );
    }else{
      debugPrint("recognitionn not null");
    }
    return Stack(
      children: stackChildren//<Widget>[
        /*Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38.0),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Currently Detected Items", style: dropdownMenuItemStyle,textAlign: TextAlign.left,),
                Text("Confidence", style: viewAllStyle,)
              ],
            ),
        ),
        Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: cityCards,//cityCards,
            ),
        ),*/
      //]
    );
  }
}

class CityCard extends StatelessWidget {
  final String imagePath,  monthYear, discount, oldPrice, newPrice;
  RecognizeData recognizeData;
  CityCard(this.imagePath,this.monthYear, this.discount, this.oldPrice, this.newPrice);

  @override
  Widget build(BuildContext context) {
    debugPrint("Present in build method of CityCard");


    final myInheritedWidget= StateContainer.of(context);
    debugPrint('myInheritedWidget contain:   $myInheritedWidget');
    recognizeData = myInheritedWidget.recognizeData;


    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 66.0,vertical: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Stack(
                    children: <Widget>[
                        Container(
                          height: 150,
                          width: 220,
                          child:  recognizeData != null
                              ? Image.file(recognizeData.uploadedImagePath)
                              : Image.asset(imagePath, fit: BoxFit.cover,)
                          //child: Image.asset(imagePath, fit: BoxFit.cover,),
                        ),
                      Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        width: 280.0,
                        height: 90.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black, Colors.black.withOpacity(0.1)
                                ]
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10.0,
                        bottom: 10.0,
                        right: 5.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                recognizeData != null
                                    ? Text('${recognizeData.label}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18.0),)
                                : Text("Website", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18.0),),

                                recognizeData != null
                                    ? Text('${recognizeData.confidence}%', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.0,),)
                                    : Text('0.91%', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.0,),),
                                //Text(monthYear, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 14.0),),
                              ],
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0),),
                                ),
                                child: recognizeData != null
                                    ? Text("${recognizeData.index}", style: TextStyle(fontSize: 14.0, color: Colors.black),)
                                    : Text("0.9", style: TextStyle(fontSize: 14.0, color: Colors.black),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ),
              /*Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 5.0,),
                  Text(newPrice,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),),
                  SizedBox(width: 5.0,),
                  Text(newPrice,style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal,),),
                ],
              )*/
            ],
          ),
    );
  }
}