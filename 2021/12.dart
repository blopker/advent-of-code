import 'dart:io';
import './lib.dart';

var day = '12';
var visits = 1;
List<List<String>> paths = [];
void main(List<String> args) {
  var testData = File('$day.test.txt').readAsLinesSync();
  print(run(testData, 1));
  print(10);
  print(run(testData, 2));
  print(36);

  var data = File('$day.txt').readAsLinesSync();
  print(run(data, 1));
  print(run(data, 2));
}

int run(List<String> data, int v) {
  visits = v;
  paths = [];
  var pairs = data.map((e) => e.split('-')).toList();
  print(pairs);
  var m = createMap(pairs);
  print(m);
  findPaths(m);
  // print(Set.from(paths));
  return Set.from(paths.map((e) => e.toString())).length;
}

void findPaths(Map<String, Set<String>> graph) {
  List<String> path = [];
  findPath(graph, 'start', path);
  // print(paths);
}

void findPath(
    Map<String, Set<String>> graph, String current, List<String> path) {
  if (path.isNotEmpty && path.last == 'end') {
    paths.add(path);
    return;
  }
  path.add(current);
  if (!isOK(path)) {
    return;
  }
  for (var p in graph[current]!) {
    if (p != 'start') {
      var pn = path.toList();
      findPath(graph, p, pn);
    }
  }
}

Map<String, Set<String>> createMap(List<List<String>> pairs) {
  Map<String, Set<String>> m = {};
  for (var p in pairs) {
    if (!m.containsKey(p[0])) {
      m[p[0]] = {};
    }
    if (!m.containsKey(p[1])) {
      m[p[1]] = {};
    }
    m[p[1]]!.add(p[0]);
    m[p[0]]!.add(p[1]);
  }
  return m;
}

bool isOK(List<String> path) {
  var s = path.where((e) => isSmall(e)).toList();
  return s.length < Set.from(s).length + visits;
}

bool isSmall(String s) {
  if (s.toLowerCase() == s) {
    return true;
  }
  return false;
}
