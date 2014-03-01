library graph_controller;

import 'dart:html';

import 'package:angular/angular.dart';

const String api_url = '127.0.0.1:8000/get/';

String zero_pad(int val, int length) {
  String output = '${val}';
  while (output.length < length) {
    output = '0${output}';
  }
  return output;
}

@NgController(
    selector: '[dart-graph]',
    publishAs: 'ctrl')
class DartGraphController {
  String symbol;
  String output;
  String address;
  
  void display_data() {
    DateTime start = DateTime.parse("1970-01-01 00:00:00");
    DateTime end = new DateTime.now();
    
    address = '${api_url}?s=${symbol}&a=${zero_pad(start.month, 2)}&b=${zero_pad(start.day, 2)}&c=${zero_pad(start.year, 4)}&d=${zero_pad(end.month, 2)}&e=${zero_pad(end.day, 2)}&f=${zero_pad(end.year, 4)}&g=d&ignore=.csv';
  }
}