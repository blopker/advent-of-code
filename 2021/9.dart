import 'dart:io';
import './lib.dart';

var day = '9';
List<List<int>> topo = [];

void main(List<String> args) {
  var testData = File('$day.test.txt').readAsLinesSync();
  print(run(testData));
  print(15);
  print(run2(testData));
  print(1134);
  var data = File('$day.txt').readAsLinesSync();
  print(run(data));
  print(run2(data));
}

int run(List<String> data) {
  topo =
      data.map((e) => e.split('').map((e) => int.parse(e)).toList()).toList();
  var score = 0;
  for (var i = 0; i < topo.length; i++) {
    for (var b = 0; b < topo[i].length; b++) {
      var l = isLow(i, b);
      if (l) {
        score += topo[i][b] + 1;
      }
    }
  }
  return score;
}

int run2(List<String> data) {
  topo =
      data.map((e) => e.split('').map((e) => int.parse(e)).toList()).toList();
  var lows = Set<Point>();
  for (var i = 0; i < topo.length; i++) {
    for (var b = 0; b < topo[i].length; b++) {
      var l = isLow(i, b);
      if (l) {
        lows.add(Point(i, b));
      }
    }
  }
  List<int> scores = [];
  for (var low in lows) {
    scores.add(getBasin(low));
  }
  scores.sort();
  scores = scores.reversed.toList();
  return scores[0] * scores[1] * scores[2];
}

var visited = Set<Point>();
int getBasin(Point low) {
  visited = Set<Point>();
  visited.add(low);
  _getBasin(low, init: true);
  return visited.length;
}

_getBasin(Point p, {bool init = false}) {
  if (visited.contains(p) && !init) {
    return;
  }
  if (topo[p.x][p.y] == 9) {
    return;
  }
  visited.add(p);
  if (p.x < topo.length - 1) {
    _getBasin(Point(p.x + 1, p.y));
  }
  if (p.x > 0) {
    _getBasin(Point(p.x - 1, p.y));
  }
  if (p.y > 0) {
    _getBasin(Point(p.x, p.y - 1));
  }
  if (p.y < topo[0].length - 1) {
    _getBasin(Point(p.x, p.y + 1));
  }
}

bool isLow(int i, int b) {
  var v = topo[i][b];
  var u = i == 0 ? 100 : topo[i - 1][b];
  var d = i == topo.length - 1 ? 100 : topo[i + 1][b];
  var l = b == 0 ? 100 : topo[i][b - 1];
  var r = b == topo[0].length - 1 ? 100 : topo[i][b + 1];
  return v < u && v < d && v < l && v < r;
}
