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

List<Point> square(double side) {
  return [Point(0,0), Point(side,0), Point(side,side), Point(0,side)];
}
List<Point> triangle(double side) {
  return [Point(0,0), Point(side/2,side), Point(side,0)];
}
// List<Point> circle(double radius) {
//   return [Point(0,0), Point(radius,0), Point(radius,radius), Point(0,radius), Point(-radius,radius), Point(-radius,0), Point(-radius,-radius), Point(0,-radius), Point(radius,-radius)];
// }
List<Point> lShape(double side){
  return [Point(0,0), Point(0, side), Point(side, side), Point(side, side/2), Point(side/2, side/2), Point(side/2, 0)];
}

// using shoelace formula: 0.5|sum(x1*y2 - x2*y1)|
double area(List<Point> points) {
  double area = 0.0;
  points.add(points[0]); // close the boundary
  for(int i = 0; i < points.length-1; i++){
    area += points[i].x*points[i+1].y - points[i+1].x*points[i].y;
  }
  return 0.5*area.abs();
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

