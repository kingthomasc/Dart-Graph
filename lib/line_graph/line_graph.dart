library line_graph;

import 'dart:html';

import 'package:angular/angular.dart';

@NgComponent(
    selector: 'line-graph',
    templateUrl: 'packages/dart_graph/line_graph/line_graph.html',
    cssUrl: 'packages/dart_graph/line_graph/line_graph.css',
    publishAs: 'cmp',
    map: const {
      'width': '@width',
      'height': '@height',
      'src': '@url',
    }
)
class LineGraph implements NgAttachAware {
  String width;
  String height;
  String url;
  String path = "M0 0 L100 100";
  
  void attach() {
    update_graph();
  }
  
  void update_graph() {
    var request = new HttpRequest();
    request..open('GET', url, async: false)
           ..send();
    
    List<Map<String, String>> output = parse_csv(request.responseText);
    
    List<num> closes = [];
    
    for (Map<String, String> item in output.reversed) {
      closes.add(num.parse(item['Adj Close']));
    }
    
    num min = closes[0];
    num max = closes[0];
    for (num i in closes) {
      if (i < min) min = i;
      else if (i > max) max = i;
    }
    num range = max - min;
    
    Function x = (num e) => (num.parse(width) / closes.length) * (e + 1);
    Function y = (num e) => num.parse(height) - (((num.parse(height) - 4) / range) * (e - min) + 2);
    
    path = "";
    for (int i = 0; i < closes.length; i++) {
      if (path == "")
        path = "M${x(i)} ${y(closes[i])} ";
      else
        path += "L${x(i)} ${y(closes[i])} ";
    }
  }
  
  List<Map<String, String>> parse_csv(String csv_data) {
    List<String> lines = csv_data.split('\n');
    List<String> headers = lines.removeAt(0).split(',');
    
    List<Map<String, String>> data = new List<Map<String, String>>();
    
    for (String line in lines) {
      Map<String, String> d = new Map<String, String>();
      List<String> items = line.split(',');
      if (items.length != headers.length)
        continue;
      for (int i = 0; i < items.length; i++) {
        d[headers[i]] = items[i];
      }
      data.add(d);
    }
    
    return data;
  }
}