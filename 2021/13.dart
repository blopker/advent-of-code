import 'dart:io';
import 'dart:math';
import './lib.dart';

var day = '13';
var flashes = 0;
Set<Point> points = {};
void main(List<String> args) {
  var testData = File('$day.test.txt').readAsLinesSync();
  print(run(testData, 1));
  print(17);
  print(run(testData, null));
  printPoints();

  var data = File('$day.txt').readAsLinesSync();
  print(run(data, 1));
  print(run(data, null));
  printPoints();
}

int run(List<String> data, int? foldsN) {
  flashes = 0;
  points = {};
  List<String> folds = [];
  for (var item in data) {
    if (item.contains(',')) {
      var p = item.split(',');
      points.add(Point(int.parse(p[0]), int.parse(p[1])));
    }
    if (item.contains('fold')) {
      folds.add(item);
    }
  }
  foldsN = foldsN == null ? folds.length : foldsN;
  for (var i = 0; i < foldsN; i++) {
    var onX = folds[i].contains('x');
    var f = int.parse(folds[i].split('=').last);
    fold(onX, f);
  }
  return points.length;
}

void fold(bool onX, int f) {
  Set<Point> s = {};
  for (var p in points) {
    if (!onX && p.y > f) {
      p.y = ((p.y - f) - f).abs();
    }
    if (onX && p.x > f) {
      p.x = ((p.x - f) - f).abs();
    }
    s.add(p);
  }
  points = s;
}

void printPoints() {
  var maxY = points.map((e) => e.y).reduce(max);
  var maxX = points.map((e) => e.x).reduce(max);
  List<List<String>> grid = [];
  for (var i = 0; i <= maxY; i++) {
    grid.add(List.filled(maxX + 1, '.'));
  }
  for (var p in points) {
    grid[p.y][p.x] = '#';
  }
  for (var l in grid) {
    print(l);
  }
}
