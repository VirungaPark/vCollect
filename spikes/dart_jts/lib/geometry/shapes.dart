import 'dart:math';
import 'package:vcollect_dart_jts_spike/geometry/point.dart';

List<Point> square(double side) {
  return [Point(0,0), Point(side,0), Point(side,side), Point(0,side)];
}
List<Point> lShape(double side){
  return [Point(0,0), Point(0, side), Point(side, side), Point(side, side/2), Point(side/2, side/2), Point(side/2, 0)];
}
List<Point> isoscelesTriangle(double side) {
  return [Point(0,0), Point(side/2,side), Point(side,0)];
}
List<Point> equilateralTriangle(double side) {
  return [Point(0,0), Point(side/2,side), Point(side,side/2)];
}
// List<Point> scaleneTriangle(double side) {
//   return []
// }

List<Point> bowTie(double side) {
 return [Point(0,0), Point(0, side), Point(side/2, side/2), Point(side, 0), Point(side, side)];
}

List<Point> figureEight(double side) {
  return [Point(0,0)]; // placeholder
}

// fix: adds a random points outside of radius
// suggestion use .buffer(0) to fix
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
