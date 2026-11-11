import 'dart:math';

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
}

class NoiseConfig {
  final double jitter;        // std dev, meters (e.g. 1.5)
  final double driftStep;     // random walk step, meters (e.g. 0.2)
  final double driftDecay;    // 0..1, pulls drift back toward 0 (e.g. 0.98)
  final double outlierProb;   // per point (e.g. 0.01)
  final double pauseProb;     // per point (e.g. 0.02)
  const NoiseConfig({
    this.jitter = 1.5, this.driftStep = 0.2, this.driftDecay = 0.98,
    this.outlierProb = 0.01, this.pauseProb = 0.02,
  });
}

double _gauss(Random r) {
  // Box-Muller
  final u1 = 1 - r.nextDouble(), u2 = r.nextDouble();
  return sqrt(-2 * log(u1)) * cos(2 * pi * u2);
}

List<NoisyPoint> addNoise(List<Point> clean, NoiseConfig c, Random rng) {
  final out = <NoisyPoint>[];
  var dx = 0.0, dy = 0.0;
  for (final p in clean) {
    dx = dx * c.driftDecay + _gauss(rng) * c.driftStep;
    dy = dy * c.driftDecay + _gauss(rng) * c.driftStep;

    var nx = p.x + dx + _gauss(rng) * c.jitter;
    var ny = p.y + dy + _gauss(rng) * c.jitter;
    var acc = 3 + rng.nextDouble() * 3;

    if (rng.nextDouble() < c.outlierProb) {
      final ang = rng.nextDouble() * 2 * pi;
      final dist = 10 + rng.nextDouble() * 20;
      nx += cos(ang) * dist;
      ny += sin(ang) * dist;
      acc = 20 + rng.nextDouble() * 30;   // outliers report worse accuracy
    }

    final np = NoisyPoint(nx, ny, acc);
    out.add(np);
    if (rng.nextDouble() < c.pauseProb) out.add(np); // duplicate = pause
  }
  return out;
}
List<Point> square(double side) {
  return [Point(0,0), Point(side,0), Point(side,side), Point(0,side)];
}
List<Point> triangle(double side) {
  return [Point(0,0), Point(side/2,side), Point(side,0)];
}
List<Point> circle(double radius, int numPoints) {
  var coords = <Point>[Point(0,0)];
  // Center is at (radius, 0) so that (0, 0) lies on the circumference
  double centerX = radius;
  double centerY = 0;

  for (int i = 0; i < numPoints; i++) {
    // Start at pi (180 degrees) so the very first point generated is (0, 0)
    double angle = pi + (i / numPoints) * 2 * pi;

    double x = centerX + radius * cos(angle);
    double y = centerY + radius * sin(angle);

    coords.add(Point(x, y));
  }
  return coords;
}
List<Point> lShape(double side){
  return [Point(0,0), Point(0, side), Point(side, side), Point(side, side/2), Point(side/2, side/2), Point(side/2, 0)];
}

// using shoelace formula: 0.5|sum(x1*y2 - x2*y1)|
double area(List<Point> points) {
  double sum = 0.0;
  for(int i = 0; i < points.length; i++){
    final a = points[i], b = points[(i + 1) % points.length];
    sum += a.x * b.y - b.x * a.y;
  }
  return 0.5*sum.abs();
}

double perimeter(List<Point> points){
  double perimeter = 0.0;
  points.add(points[0]); // close the boundary
  for(int i = 0; i < points.length-1; i++){
    // d = sqrt((x2-x1)^2 + (y2-y1)^2)
    perimeter += (sqrt(pow(points[i+1].x - points[i].x, 2) + pow(points[i+1].y - points[i].y, 2)));
  }
  return perimeter;
}

void main(){
  print(area(lShape(5)));
  print(area(triangle(5)));
  print(perimeter(square(2)));
  print(perimeter(triangle(5)));
}