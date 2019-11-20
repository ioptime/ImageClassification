///  This file has access across our App

import 'package:flutter/material.dart';

import 'RecognizeData.dart';


class StateContainer extends StatefulWidget {
  final Widget child;
  final RecognizeData recognizeData;

  StateContainer({@required this.child, this.recognizeData});

  static _StateContainerState of(BuildContext context){
    return(context.inheritFromWidgetOfExactType(InheritedContainer) as InheritedContainer).data;
  }

  @override
  _StateContainerState createState() => _StateContainerState();
}

class _StateContainerState extends State<StateContainer> {
  RecognizeData recognizeData;

  /// Now add the details to the properties
  void updateRecognitionInfo({imageConfidence,imageIndex, imageLabel,imagePath}){
    if(recognizeData == null){
      debugPrint('Present in updateRecognitionInfo method and recognizeData is null');
      recognizeData = new RecognizeData(confidence:imageConfidence, index:imageIndex, label: imageLabel,uploadedImagePath: imagePath);
      setState(() {
        recognizeData = recognizeData;
      });
    }
    else{
      debugPrint('Present in updateRecognitionInfo method and recognizeData is not null');
      setState(() {
        recognizeData.confidence=imageConfidence ?? imageConfidence;
        recognizeData.index=imageIndex ?? imageIndex;
        recognizeData.label=imageLabel ?? imageLabel;
        recognizeData.uploadedImagePath=imagePath ?? imagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InheritedContainer(
      data:this,
      child: widget.child,
    );
  }
}

class InheritedContainer extends InheritedWidget{
  final _StateContainerState data;

  InheritedContainer({Key key,@required this.data,@required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedContainer oldWidget){
    return true;
  }
}