import 'dart:io';
import 'dart:math';

void main(List<String> args) {
  var testData = File('5.test.txt').readAsLinesSync();
  print(run(testData, 10));
  print(runp2(testData, 10));
  var data = File('5.txt').readAsLinesSync();
  print(run(data, 1000));
  print(runp2(data, 1000));
}

int run(List<String> data, int size) {
  var board = List.generate(size, (index) => List.generate(size, (index) => 0));
  var points = parsePoints(data);
  var vertPoints =
      points.where((e) => e[0].x == e[1].x || e[0].y == e[1].y).toList();
  // print(points);
  // print(vertPoints);
  var lines = makeLines(vertPoints);
  fillBoard(board, lines);
  for (var b in board) {
    // print(b);
  }
  return scoreBoard(board);
}

int runp2(List<String> data, int size) {
  var board = List.generate(size, (index) => List.generate(size, (index) => 0));
  var points = parsePoints(data);
  // print(points);
  var lines = makeLines(points);
  fillBoard(board, lines);
  for (var b in board) {
    // print(b);
  }
  return scoreBoard(board);
}

int scoreBoard(List<List<int>> board) {
  var score = 0;
  for (var l in board) {
    for (var p in l) {
      if (p > 1) {
        score += 1;
      }
    }
  }
  return score;
}

List<List<Point>> makeLines(List<List<Point>> points) {
  // y = mx + b
  // 𝑚=𝑦2−𝑦1𝑥2−𝑥1
  List<List<Point>> lines = [];
  for (var pair in points) {
    var line = [pair[0]];
    var dx = pair[1].x - pair[0].x;
    var dy = pair[1].y - pair[0].y;
    var steps = max(dx.abs(), dy.abs());
    for (var i = 0; i < steps; i++) {
      line.add(Point(line.last.x + dx.sign, line.last.y + dy.sign));
    }
    // print(line);
    lines.add(line);
  }
  // print(lines);
  return lines;
}

List<List<Point>> parsePoints(List<String> data) {
  List<List<Point>> lines = [];
  for (var line in data) {
    var points = line.replaceAll(' ', '').split('->');
    var a = [Point.fromString(points[0]), Point.fromString(points[1])];
    lines.add(a);
  }
  return lines;
}

class Point {
  int x = 0;
  int y = 0;
  Point(this.x, this.y);
  Point.fromString(String s) {
    var b = s.split(',');
    this.x = int.parse(b[0]);
    this.y = int.parse(b[1]);
  }
  @override
  String toString() {
    return 'Point($x, $y)';
  }
}

void fillBoard(List<List<int>> board, List<List<Point>> lines) {
  for (var line in lines) {
    for (var point in line) {
      board[point.y][point.x] += 1;
    }
  }
}
