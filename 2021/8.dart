import 'dart:io';

var day = '8';

void main(List<String> args) {
  var testData = File('$day.test.txt').readAsLinesSync();
  print(run(testData));
  print(26);
  print(run2(testData));
  print(61229);
  var data = File('$day.txt').readAsLinesSync();
  print(run(data));
  print(run2(data));
}

int run(List<String> data) {
  var values = data
      .map((e) => e.split(' | ').map((e) => e.split(' ')).toList())
      .toList();
  var outputs = values.map((e) => e[1]).toList();
  var count = 0;
  var u = Set.from([2, 4, 3, 7]);
  for (var o in outputs) {
    for (var d in o) {
      if (u.contains(d.length)) {
        count += 1;
      }
    }
  }
  return count;
}

int run2(List<String> data) {
  var values = data
      .map((e) => e.split(' | ').map((e) => e.split(' ')).toList())
      .toList();
  var count = 0;
  for (var o in values) {
    var wireMap = getMap(o[0]);
    var out = toNumber(o[1][0], wireMap) * 1000;
    out += toNumber(o[1][1], wireMap) * 100;
    out += toNumber(o[1][2], wireMap) * 10;
    out += toNumber(o[1][3], wireMap) * 1;
    count += out;
  }
  return count;
}

int toNumber(String o, List<Set<String>> wireMap) {
  var s = Set.from(o.split(''));
  for (var i = 0; i < wireMap.length; i++) {
    if (s.containsAll(wireMap[i]) && wireMap[i].containsAll(s)) {
      return i;
    }
  }
  return 0;
}

List<Set<String>> getMap(List<String> o) {
  List<Set<String>> n = o.map((e) => Set<String>.from(e.split(''))).toList();
  var one = n.firstWhere((e) => e.length == 2);
  var seven = n.firstWhere((e) => e.length == 3);
  var four = n.firstWhere((e) => e.length == 4);
  var eight = n.firstWhere((e) => e.length == 7);
  var nine = n.firstWhere(
      (e) => e.containsAll(seven) && e.containsAll(four) && e.length == 6);
  var six = n.firstWhere(
      (e) => e.length == 6 && !e.containsAll(nine) && !e.containsAll(one));
  var five = n.firstWhere((e) => e.length == 5 && six.containsAll(e));
  var zero = n.firstWhere(
      (e) => e.length == 6 && !e.containsAll(nine) && !e.containsAll(six));
  var three = n.firstWhere(
      (e) => e.length == 5 && e.containsAll(one) && !e.containsAll(five));
  var two = n.firstWhere(
      (e) => e.length == 5 && !e.containsAll(one) && !e.containsAll(five));
  return [zero, one, two, three, four, five, six, seven, eight, nine];
}
