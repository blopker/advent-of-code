import 'dart:io';
import './lib.dart';

var day = '10';

var points = {')': 3, ']': 57, '}': 1197, '>': 25137};
var points2 = {')': 1, ']': 2, '}': 3, '>': 4};
var openers = {'(': ')', '[': ']', '{': '}', '<': '>'};
var closers = {')': '(', ']': '[', '}': '{', '>': '<'};

void main(List<String> args) {
  var testData = File('$day.test.txt').readAsLinesSync();
  print(run(testData));
  print(26397);
  print(run2(testData));
  print(288957);
  var data = File('$day.txt').readAsLinesSync();
  print(run(data));
  print(run2(data));
}

int run(List<String> data) {
  var score = 0;
  for (var line in data) {
    var s = getBad(line);
    if (s != null) {
      score += points[s]!;
    }
  }
  return score;
}

int run2(List<String> data) {
  var scores = <int>[];
  for (var line in data) {
    var s = getBad(line);
    if (s != null) {
      continue;
    }
    var d = balance(line);
    scores.add(d);
  }
  scores.sort();
  // print(scores);
  return scores[(scores.length / 2).floor()];
}

int balance(String line) {
  var s = [];
  for (var a in line.split('')) {
    if (openers.keys.contains(a)) {
      s.add(a);
    } else {
      s.removeLast();
    }
  }
  var score = 0;
  for (var a in s.reversed) {
    score *= 5;
    score += points2[openers[a]!]!;
  }
  // print(score);
  // print(s);
  return score;
}

String? getBad(String line) {
  var s = [];
  for (var a in line.split('')) {
    if (openers.keys.contains(a)) {
      s.add(a);
    } else {
      if (closers[a] != s.last) {
        return a;
      }
      s.removeLast();
    }
  }
  return null;
}
