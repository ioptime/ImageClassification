import 'package:flutter/material.dart';

class GenericFunctions{
  static String confidence;
  static String index;
  static String label;
  static var data;
  static bool isDataReceived = false;

  static List myValue;

  //static var recognizeData;
  void recognizeData(var _recognitions){
    debugPrint('value of recognitions is $_recognitions');
    if(_recognitions != null){
      data =_recognitions;
      //myValue = _recognitions;
      isDataReceived = true;
      if(isDataReceived){
        debugPrint('isDataReceived $isDataReceived');
      }else{
        debugPrint('isDataReceived $isDataReceived');
      }
    }
    debugPrint('value of data in recognizeData() function is  $data');
  }
  static List getData(){
    return data;
  }

}