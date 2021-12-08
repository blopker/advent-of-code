import 'dart:io';

var test = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263];

void main(List<String> args) async {
  print(countInc(test));
  print(count3Inc(test));
  var data = await File('1.txt').readAsLines();
  var intList = data.map((e) => int.parse(e)).toList();
  print(countInc(intList));
  print(count3Inc(intList));
}

int countInc(List<int> intList) {
  var prev = 0;
  var incCount = -1;
  for (var d in intList) {
    if (d > prev) {
      incCount++;
    }
    prev = d;
  }
  return incCount;
}

int count3Inc(List<int> intList) {
  var incCount = 0;
  for (var i = 0; i < intList.length - 3; i++) {
    var a = intList[i] + intList[i + 1] + intList[i + 2];
    var b = intList[i + 1] + intList[i + 2] + intList[i + 3];
    if (b > a) {
      incCount++;
    }
  }
  return incCount;
}
