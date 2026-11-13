import 'package:vcollect_dart_jts_spike/io/convert.dart';
import 'package:test/test.dart';
import 'package:vcollect_dart_jts_spike/geometry/shapes.dart';

void main(){
  test('polygons intersect', () {
    var simpleSquare = square(100);
    var coordinates1 = convertPointsToCoordinates(simpleSquare);
    var coordinates2 = convertPointsToCoordinates(simpleSquare);
    var polygon1 = convertToPolygon(coordinates1);
    var polygon2 = convertToPolygon(coordinates2);
    bool result = polygon1.intersects(polygon2);
    expect(result, true);
  });
  test('polygons do not intersect', () {
    var simpleSquare = square(100);
    var simpleNegativeSquare = square(-100);
    var coordinates1 = convertPointsToCoordinates(simpleSquare);
    var coordinates2 = convertPointsToCoordinates(simpleNegativeSquare);
    var polygon1 = convertToPolygon(coordinates1);
    var polygon2 = convertToPolygon(coordinates2);
    bool result = polygon1.equals(polygon2);
    expect(result, false);
  });
}