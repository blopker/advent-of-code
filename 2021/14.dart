import 'dart:io';
import 'dart:math';

var day = '14';
var flashes = 0;
Set<Point> points = {};
void main(List<String> args) {
  var testData = File('$day.test.txt').readAsLinesSync();
  print(run(testData, 10));
  print(run(testData, 40));

  var data = File('$day.txt').readAsLinesSync();
  print(run(data, 10));
  print(run(data, 40));
}

int run(List<String> data, int steps) {
  var template = data[0];
  Map<String, int> counter = {};
  for (var l in template.split('')) {
    counter[l] = (counter[l] ?? 0) + 1;
  }
  Map<String, String> letterMap = {};
  for (var i = 2; i < data.length; i++) {
    var pair = data[i].split(' -> ');
    letterMap[pair[0]] = pair[1];
  }
  Map<String, int> pairs = {};
  for (var i = 0; i < template.length - 1; i++) {
    var k = '${template[i]}${template[i + 1]}';
    pairs[k] = (pairs[k] ?? 0) + 1;
  }
  for (var i = 0; i < steps; i++) {
    Map<String, int> new_pairs = {};
    for (var k in pairs.keys) {
      var count = pairs[k]!;
      var l = [k[0] + letterMap[k]!, letterMap[k]! + k[1]];
      new_pairs[l[0]] = (new_pairs[l[0]] ?? 0) + count;
      new_pairs[l[1]] = (new_pairs[l[1]] ?? 0) + count;
      counter[letterMap[k]!] = (counter[letterMap[k]] ?? 0) + count;
    }
    pairs = new_pairs;
  }
  var minC = counter.values.reduce(min);
  var maxC = counter.values.reduce(max);
  return maxC - minC;
}
