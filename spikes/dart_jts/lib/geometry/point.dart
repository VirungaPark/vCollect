// defining a point class allows control over attributes
class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);

  @override // convert to string for printing
  String toString() {
    return 'Point($x, $y)';
  }
}
class NoisyPoint extends Point {
  final double accuracy;
  NoisyPoint(super.x, super.y, this.accuracy);
  @override
  String toString() {
    return 'NoisyPoint($x, $y, $accuracy)';
  }
}