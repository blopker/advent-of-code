import 'dart:io';
import 'dart:math';

var day = '15';

Map<int, List<int>> graph = {};
List<List<int>> wieghts = [];
Set<int> visited = {};
Map<int, int> distances = {};
var pq = PQ();
var minPath = 99999999;
var INF = 99999999;

void main(List<String> args) {
  var testData = File('$day.test.txt').readAsLinesSync();
  print(run(testData, false));
  print(40);
  print(run(testData, true));
  print(315);
  var data = File('$day.txt').readAsLinesSync();
  print(run(data, false));
  print(run(data, true));
}

int run(List<String> data, bool big) {
  wieghts = [];
  graph = {};
  minPath = 900;
  pq.clear();
  for (var item in data) {
    wieghts.add(item.split('').map((e) => int.parse(e)).toList());
  }
  if (big) {
    makeBig();
  }
  // print(wieghts);
  for (var i = 0; i < wieghts.length; i++) {
    for (var d = 0; d < wieghts[i].length; d++) {
      int k = i * wieghts[i].length + d;
      List<int> ad = [];
      if (d > 0) {
        ad.add(k - 1);
      }
      if (d < wieghts[i].length - 1) {
        ad.add(k + 1);
      }
      if (i > 0) {
        ad.add(k - wieghts[i].length);
      }
      if (i < wieghts.length - 1) {
        ad.add(k + wieghts[i].length);
      }
      graph[k] = ad;
    }
  }
  // print(graph);
  return findShortest();
}

void makeBig() {
  var l = wieghts.length;
  for (var i = 0; i < l; i++) {
    for (var b = 0; b < l * 4; b++) {
      var w = (wieghts[i][b] + 1) % 10;
      w = w == 0 ? 1 : w;
      wieghts[i].add(w);
    }
  }
  for (var i = 0; i < l * 4; i++) {
    wieghts.add([]);
    for (var b = 0; b < l * 5; b++) {
      var w = (wieghts[i][b] + 1) % 10;
      w = w == 0 ? 1 : w;
      wieghts.last.add(w);
    }
  }
  // for (var item in wieghts) {
  //   print(item);
  // }
  // print(wieghts);
}

int findShortest() {
  var end = graph.keys.reduce(max);
  // Set<List<int>> paths = {};
  // List<int> path = [0];
  // _findShortest(end, 0, 0);
  visited = {};
  distances = {};
  for (var k in graph.keys) {
    distances[k] = 999999;
  }
  distances[0] = 0;
  pq.add(0);
  while (pq._stack.length != 0) {
    _findDistance(pq.pop());
    // print(visited);
  }
  // print(distances);
  return distances[end]!;
}

void _findDistance(int i) {
  visited.add(i);
  for (var n in graph[i]!) {
    if (visited.contains(n)) {
      // print('hey $n');
      continue;
    }
    // print('ho $n');
    // print(visited);
    var new_distance = getWeight(n) + distances[i]!;
    if (new_distance < distances[n]!) {
      distances[n] = new_distance;
      // print(new_distance);
      // print(distances);
      pq.add(n);
    }
  }
}

int getWeight(int n) {
  return wieghts[n ~/ wieghts.length][n % wieghts[0].length];
}

class PQ {
  List<int> _stack = [];
  add(int i) {
    _stack.add(i);
    _sort();
  }

  _sort() {
    _stack.sort((a, b) => distances[a]!.compareTo(distances[b]!));
  }

  int pop() {
    // _sort();
    print(_stack.length);
    return _stack.removeAt(0);
  }

  clear() {
    _stack = [];
  }
}

// void _findShortest(int end, int last, int score) {
//   // print(score);
//   if (score > minPath) {
//     return;
//   }
//   if (last == end) {
//     print(score);
//     minPath = score;
//     return;
//   }
//   // print(path);
//   for (var n in graph[last]!) {
//     // if (path.contains(n)) {
//     //   continue;
//     // }
//     // var new_path = path.toList();
//     // new_path.add(n);
//     var new_score = score + wieghts[n ~/ wieghts.length][n % wieghts[0].length];
//     // print(new_path);
//     if (new_score > minPath) {
//       continue;
//     }
//     _findShortest(end, n, new_score);
//   }
// }
