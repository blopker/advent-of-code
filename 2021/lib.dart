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

  int _hashCode = 0;
  @override
  int get hashCode {
    if (_hashCode == 0) {
      _hashCode = toString().hashCode;
    }
    return _hashCode;
  }

  @override
  bool operator ==(other) {
    if (other is! Point) {
      return false;
    }
    return x == other.x && y == other.y;
  }
}
