import 'dart:io';
import './lib.dart';

var day = '17';

void main(List<String> args) async {
  var testData = File('$day.test.txt').readAsLines();
  var data = File('$day.txt').readAsLines();
  print(run(await testData));
  print(45);
  print(run(await data));
}

int run(List<String> data) {
  var t = Target.fromData(data[0]);
  List<List<Point>> hitPaths = [];
  for (var y = -1000; y < 1000; y++) {
    for (var x = 0; x < 1000; x++) {
      var path = getPath(x, y, t);
      if (t.pathHit(path)) {
        hitPaths.add(path);
      }
    }
  }
  var maxy = 0;
  for (var p in hitPaths) {
    for (var point in p) {
      if (point.y > maxy) {
        maxy = point.y;
      }
    }
  }
  print(t);
  print('hitPaths: ${hitPaths.length}');
  return maxy;
}

List<Point> getPath(int vx, int vy, Target t) {
  List<Point> path = [];
  var x = 0;
  var y = 0;
  path.add(Point(x, y));
  while (x <= t.x2 * 2 && y >= t.y2 * 2) {
    x = x + vx;
    vx = vx == 0 ? 0 : (vx - 1);
    y = y + vy;
    vy = vy - 1;
    path.add(Point(x, y));
  }
  return path;
}

class Target {
  final int x1;
  final int x2;
  final int y1;
  final int y2;
  Target(this.x1, this.x2, this.y1, this.y2);
  factory Target.fromData(String data) {
    //target area: x=20..30, y=-10..-5
    var coords = data.split(':')[1].split(',');
    var convert = (String e) {
      return e.split('=')[1].split('..').map(int.parse).toList();
    };
    var x = convert(coords[0]);
    var y = convert(coords[1]);
    return Target(x[0], x[1], y[0], y[1]);
  }

  bool hit(Point p) {
    return p.x >= x1 && p.x <= x2 && p.y >= y1 && p.y <= y2;
  }

  bool pathHit(List<Point> path) {
    for (var item in path) {
      if (hit(item)) {
        return true;
      }
    }
    return false;
  }

  @override
  String toString() {
    return 'Target(x1: $x1, x2: $x2, y1: $y1, y2: $y2)';
  }
}
