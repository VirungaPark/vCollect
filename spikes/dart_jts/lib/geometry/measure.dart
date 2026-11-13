import 'dart:math';
import 'package:vcollect_dart_jts_spike/geometry/point.dart';
// using shoelace formula: 0.5|sum(x1*y2 - x2*y1)|
double area(List<Point> points) {
  double sum = 0.0;
  for(int i = 0; i < points.length; i++){
    final a = points[i], b = points[(i + 1) % points.length];
    sum += a.x * b.y - b.x * a.y;
  }
  return 0.5*sum.abs();
}
// return the perimeter of a polygon
double perimeter(List<Point> points){
  double sum = 0.0;
  for(int i = 0; i < points.length; i++){
    final a = points[i], b = points[(i + 1) % points.length];
    sum += sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2));
  }
  return sum;
}