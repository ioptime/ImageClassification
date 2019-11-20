import 'dart:io';

class RecognizeData{
  String confidence;
  String index;
  String label;
  File uploadedImagePath;
  RecognizeData({this.confidence, this.index, this.label, this.uploadedImagePath});

}