class Point {
  int x = 0;
  int y = 0;
  Point(this.x, this.y);

  Point.fromString(String s) {
    var b = s.split(',');
    this.x = int.parse(b[0]);
    this.y = int.parse(b[1]);
  }

  @override
  String toString() {
    return 'Point($x, $y)';
  }

  @override
  int get hashCode {
    return toString().hashCode;
  }

  @override
  bool operator ==(other) {
    if (other is! Point) {
      return false;
    }
    return x == other.x && y == other.y;
  }
}
