import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imageclassificationapp/CustomAppBar.dart';
import 'package:imageclassificationapp/MyInheritedWidget.dart';
import 'package:imageclassificationapp/RecognizeData.dart';
import 'package:imageclassificationapp/tensorflowwork.dart';
import 'package:tflite/tflite.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'CustomShapeClipper.dart';
import 'GenericFunctions.dart';

void main() {
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  //Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
 /* FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZoned<Future<void>>(() async {
    runApp(StateContainer(
      child: MaterialApp(
        title: "Image Classification App",
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: HomeScreen(),
      ),
    ));
  }, onError: Crashlytics.instance.recordError);*/


  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(StateContainer(
    child: MaterialApp(
        title: "Image Classification App",
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: HomeScreen(),
      ),
  ),
  );
}

Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);

ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFF3791A),
  /*fontFamily: 'Roboto',*/
);

List<String> listItem = ['IOPTIME', 'IOPTIME (US)'];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("Pressent in HomeScreen build method");
    //Crashlytics.instance.crash();
    return Scaffold(
      /*bottomNavigationBar: CustomAppBar(),*/
      resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HomeScreenTopPart(),
              TensorFlowWork(),  //HomeScreenBottom Part
              //HomeScreenBottomPart(),
            ],
          ),
        ),
    );
  }
}

const TextStyle dropdownLabelStyle = TextStyle(color: Colors.white, fontSize: 16.0);
const TextStyle dropdownMenuItemStyle = TextStyle(color: Colors.black, fontSize: 16.0);

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {

  var selectedLocationIndex = 0;
  var isFlightSelected = true;

  @override
  Widget build(BuildContext context) {
    debugPrint("Present in build _HomeScreenTopPartState");

    //  We have a background with gradiant color
        //  So we have to take a STACk widget which contain a Container behind and other elements are Top on it
    return Stack(
      children: <Widget>[
        // ClpPath is used for custom shape
            //  Actually the purpose of clipper is to clip the container in a shaper which we define by a path.  Clipper works like an X Y cordinates
            //  Path basicallly start from 0.0 at go to the bottom which will contain the height of container.
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 385,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  firstColor,
                  secondColor
                ]
              )
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50.0,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          //Icon(Icons.location_on, color: Colors.white,),
                          SizedBox(width: 16.0,),
                          PopupMenuButton(
                            onSelected: (index){
                              setState(() {
                                selectedLocationIndex = index;
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Text(listItem[selectedLocationIndex], style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white/*,fontFamily: 'Roboto'*/),),
                                //Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                              ],
                            ),
                            itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                              PopupMenuItem(
                                child: Text(listItem[0], style: dropdownMenuItemStyle,),
                              ),
                              PopupMenuItem(
                                child: Text(listItem[1], style: dropdownMenuItemStyle,),
                              )
                            ],
                          ),
                          Spacer(),
                          //Icon(Icons.settings, color: Colors.white,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0,),
                  Text("Image Classification", style: TextStyle(fontSize: 24.0, color: Colors.white,),textAlign: TextAlign.center,),
                  SizedBox(height: 30,),
                  /*Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      child: TextField(
                        controller: TextEditingController(text: "Search our Projects"),
                        style: dropdownMenuItemStyle,
                        cursorColor: appTheme.primaryColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 14.0),
                          border: InputBorder.none,
                          suffixIcon: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            child: Icon(Icons.search, color: Colors.black,),
                          ),
                        ),
                      ),
                    ),
                  ),*/
                  SizedBox(height: 20,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ChoiceFull(Icons.cloud_upload,"Upload Image", isFlightSelected),
                      SizedBox(width: 20.0),
                      //ChoiceFull(Icons.flight,"Image ", isFlightSelected),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

// Constants
const String mobile = "MobileNet";
class ChoiceFull extends StatefulWidget {
  final IconData icon;
  final String text;
  final isBoolSelected;
  ChoiceFull(this.icon, this.text, this.isBoolSelected);
  @override
  _ChoiceFullState createState() => _ChoiceFullState();
}

class _ChoiceFullState extends State<ChoiceFull> {
  GenericFunctions genericFunctions;
  bool isRecognitionComplete = false;
  String _model = mobile;
  File _image;
  double _imageHeight;
  double _imageWidth;
  bool _busy = false;
  List _recognitions;
  RecognizeData recognizeData;

  //  Below variable is helpfull when recognition is complete
  String confidence;
  String index;
  String label;
  File imagePath;

  @override
  void initState() {
    super.initState();
    debugPrint("Present in initState()");

     _busy = true;

    loadModel().then((val) {
      setState(() {
        debugPrint('...  going to set the _busy to false  ...');
        _busy = false;
      });
    });
    genericFunctions = new GenericFunctions();
  }

  Future loadModel() async {
    debugPrint('Present in Future loadModel() async');
    Tflite.close();
    try {
      String res;
      switch (_model) {
        case mobile:
          res = await Tflite.loadModel(
            model: "assets/models/mobilenet_v1_1.0_224.tflite",
            labels: "assets/models/mobilenet_v1_1.0_224.txt",
          );
          break;
      }
      print('res: $res');
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Present in build method of _ChoiceFullState');
    return GestureDetector(
      onTap: (){
        uploadImage();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              widget.icon,
              size: 20,
              color: Colors.white,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              widget.text,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  void uploadImage()async{
    debugPrint("Present in upload Image");
    //
    bool isImageUploaded = await getImageFromGallery();
    if(isImageUploaded == true){
      debugPrint('Yes Image is Uploaded');
      //List data = GenericFunctions.getData();
      //debugPrint('data ki value $data');
    }
    else{
      debugPrint('No image is not uploaded successfully');
    }
  }

  Future getImageFromGallery() async {
    debugPrint("Present in getImageFromGallery() method");
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      debugPrint('image: $image  _image: $image');
      _busy = true;
    });
    bool isRecognitionIsCompleteOrNot =await predictImage(image);
    if(isRecognitionIsCompleteOrNot ==  true){
      debugPrint("isRecognitionCompleteOrNot is true it means _recognition is set");
      debugPrint('So, the value of _recognition is $_recognitions');
      //genericFunctions.recognizeData(_recognitions);
    }
    else{
      debugPrint("isRecognitionComplete is false");
    }
    return isRecognitionIsCompleteOrNot;
  }

  Future predictImage(File image) async {
    debugPrint('Present in predictImage(File image)');
    if (image == null) return null;

    debugPrint('File image $image');

    bool r = await recognizeImage(image);
    debugPrint('r: $r');

    new FileImage(image)
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
        setState(() {
          _imageHeight = info.image.height.toDouble();
          _imageWidth = info.image.width.toDouble();
        });
      })
    );

    setState(() {
      _image = image;
      _busy = false;
    });
    return r;
  }
  Future recognizeImage(File image) async {
    debugPrint('recognizeImage(File image) Present');
    debugPrint('path: image.path $image ');
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      debugPrint("Present in setState() of recognizeImage(File image) function");
      _recognitions = recognitions;
      debugPrint('value of _recognitions is::    $_recognitions    value of recognitions is:: $recognitions');
      debugPrint("before parsing");

      if(_recognitions != null){
        //debugPrint("index" + index);
        debugPrint("Congrats _recognition in not null");
        _recognitions.map((res) {
          confidence = res["confidence"].toStringAsFixed(3);
          index = res["confidence"].toStringAsFixed(1);
          label = res["label"];
        }).toList();
        imagePath = image;
        isRecognitionComplete = true;


        /// **********   This is the point where we send data to Inherited Widget  ***************  ///
        submitRecognizeDetail(confidence,index,label,imagePath);
        // ignore: unnecessary_statements
        //TensorFlowWork.myValue == recognitions;
        //debugPrint('Value of TensorFlowWork.myValue in main.dart is ${TensorFlowWork.myValue}');
      }else{
        debugPrint("_recognition is null");
        isRecognitionComplete = false;
      }
    });
    //genericFunctions.recognizeData(_recognitions);
    return isRecognitionComplete;
  }
  submitRecognizeDetail(String confidence,String index, String label, File imagePath){
    debugPrint('Present in submitRecognizeDetail() method');
    final myInheritedWidget = StateContainer.of(context);
    myInheritedWidget.updateRecognitionInfo(
        imageConfidence: confidence,
        imageIndex: index,
        imageLabel: label,
        imagePath: imagePath
    );
  }
}


/*class HomeScreenBottomPart extends StatefulWidget {
  @override
  _HomeScreenBottomPartState createState() => _HomeScreenBottomPartState();
}

class _HomeScreenBottomPartState extends State<HomeScreenBottomPart> {
  String s = "str";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TensorFlowWork(),
    );
  }
}*/
