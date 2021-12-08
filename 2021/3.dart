import 'dart:io';
import 'dart:math';

var test = [
  '00100',
  '11110',
  '10110',
  '10111',
  '10101',
  '01111',
  '00111',
  '11100',
  '10000',
  '11001',
  '00010',
  '01010'
];
void main(List<String> args) async {
  var a = toint(test);
  print(get3(a, 5) == 198);
  print(get3p2(a, 5) == 230);
  var data = await File('3.txt').readAsLines();
  // print(data);
  var intList = toint(data);
  // print(intList);
  print(get3(intList, 12));
  print(get3p2(intList, 12));
}

int get3(List<int> iList, bitCount) {
  List<int> c = [];
  for (var i = 0; i < bitCount; i++) {
    c.insert(0, mostCommon(iList, i));
  }
  var a = lToInt(c);
  var b = (~a).toUnsigned(bitCount);
  return a * b;
}

int get3p2(List<int> iList, int bitCount) {
  var a = getOxygenRating(iList, bitCount);
  // var b = 1;
  var b = getCO2Rating(iList, bitCount);
  return a * b;
}

int getOxygenRating(List<int> iList, int bitCount) {
  var filtered = iList.toList();
  for (var i = 0; i < bitCount; i++) {
    var pos = bitCount - i - 1;
    var c = mostCommon(filtered, pos);
    filtered.removeWhere((e) => e >> pos & 1 != c);
    if (filtered.length == 1) {
      break;
    }
  }
  return filtered[0];
}

int getCO2Rating(List<int> iList, int bitCount) {
  var filtered = iList.toList();
  for (var i = 0; i < bitCount; i++) {
    var pos = bitCount - i - 1;
    var c = mostCommon(filtered, pos);
    filtered.removeWhere((e) => e >> pos & 1 == c);
    if (filtered.length == 1) {
      break;
    }
  }
  return filtered[0];
}

List<int> toint(List<String> sList) {
  return sList.map((e) => int.parse(e, radix: 2)).toList();
}

int mostCommon(List<int> intList, int pos) {
  var c = 0;
  for (var a in intList) {
    c += a >> pos & 1;
  }
  if (c >= intList.length / 2) {
    return 1;
  }
  return 0;
}

int lToInt(List<int> iList) {
  var out = 0;
  for (var i = 0; i < iList.length; i++) {
    out += iList[i] * pow(2, iList.length - 1 - i).toInt();
  }
  return out;
}
