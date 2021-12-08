import 'dart:io';

var test = [
  'forward 5',
  'down 5',
  'forward 8',
  'up 3',
  'down 8',
  'forward 2',
];

void main(List<String> args) async {
  print(dive(test));
  print(dive2(test));
  var data = await File('2.txt').readAsLines();
  print(dive(data));
  print(dive2(data));
}

int dive(List<String> sList) {
  var x = 0;
  var y = 0;
  for (var d in sList) {
    var a = d.split(' ');
    var command = a[0];
    var i = int.parse(a[1]);
    if (command == 'forward') {
      x += i;
    } else if (command == 'up') {
      y -= i;
    } else if (command == 'down') {
      y += i;
    }
  }
  return x * y;
}

int dive2(List<String> sList) {
  var x = 0;
  var y = 0;
  var aim = 0;
  for (var d in sList) {
    var a = d.split(' ');
    var command = a[0];
    var i = int.parse(a[1]);
    if (command == 'forward') {
      x += i;
      y += i * aim;
    } else if (command == 'up') {
      aim -= i;
    } else if (command == 'down') {
      aim += i;
    }
  }
  return x * y;
}
