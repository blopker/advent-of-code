import 'dart:io';

var day = '7';

void main(List<String> args) {
  var testData = File('$day.test.txt').readAsLinesSync();
  print(run(testData, score1));
  print(37);
  print(run(testData, score2));
  print(168);
  var data = File('$day.txt').readAsLinesSync();
  print(run(data, score1));
  print(run(data, score2));
}

int run(List<String> testData, Function scoreFunction) {
  var positions = testData[0].split(',').map((e) => int.parse(e)).toList();
  var l = positions.length;
  var min = scoreFunction(positions, 0);
  for (var i = 1; i < l; i++) {
    var s = scoreFunction(positions, i);
    if (s < min) {
      min = s;
    }
    // print(s);
  }
  return min;
}

int score2(List<int> positions, int p) {
  var s = 0;
  for (var i = 0; i < positions.length; i++) {
    var a = (positions[i] - p).abs();
    s += a * (a + 1) ~/ 2;
  }
  return s;
}

int score1(List<int> positions, int p) {
  var s = 0;
  for (var i = 0; i < positions.length; i++) {
    s += (positions[i] - p).abs();
  }
  return s;
}
