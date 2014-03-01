library dart_graph;

import 'package:angular/angular.dart';

import 'package:dart_graph/GraphController.dart';
import 'package:dart_graph/line_graph/line_graph.dart';

@MirrorsUsed(targets: const['dart_graph'], override: '*')
import 'dart:mirrors';

void main() {
  ngBootstrap(module: new MyAppModule());
}

class MyAppModule extends Module {
  MyAppModule() {
    type(LineGraph);
    type(DartGraphController);
  }
}

