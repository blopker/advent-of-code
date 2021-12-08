import 'dart:io';

var day = '6';

void main(List<String> args) {
  var testData = File('$day.test.txt').readAsLinesSync();
  print(run(testData, 80));
  print(5934);
  print(run(testData, 256));
  print(26984457539);
  var data = File('$day.txt').readAsLinesSync();
  print(run(data, 80));
  print(run(data, 256));
}

int run(List<String> data, int days) {
  var timers = data[0].split(',').map((e) => int.parse(e));
  var timerMap = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0};
  for (var t in timers) {
    timerMap.update(t, (e) => e + 1);
  }
  for (var i = 0; i < days; i++) {
    tick(timerMap);
  }
  return timerMap.values.reduce((value, element) => value + element);
}

void tick(Map<int, int> timerMap) {
  var zeros = timerMap[0] ?? 0;
  for (var i = 1; i < 9; i++) {
    timerMap[i - 1] = timerMap[i] ?? 0;
  }
  timerMap[8] = zeros;
  timerMap.update(6, (e) => e + zeros);
}
