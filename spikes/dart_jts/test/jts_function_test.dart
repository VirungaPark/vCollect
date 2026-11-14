import 'package:vcollect_dart_jts_spike/io/convert.dart';
import 'package:test/test.dart';
import 'package:vcollect_dart_jts_spike/geometry/shapes.dart';
import 'package:vcollect_dart_jts_spike/geometry/point.dart';
import 'package:vcollect_dart_jts_spike/generate/noise.dart';
import 'package:vcollect_dart_jts_spike/generate/resample.dart';
import 'package:vcollect_dart_jts_spike/geometry/measure.dart';
import 'dart:math';
import 'package:dart_jts/dart_jts.dart' as jts;
import 'package:vector_math/vector_math_64.dart';

void main(){
  group('JTS Polygon Validity', () {
    test('validates clean polygons', (){
      final shapes = {
        'square': square(100),
        'triangle': equilateralTriangle(100),
        'lShape': lShape(100),
      };
      shapes.forEach((name, points) {
        final polygon = convertToPolygon(convertPointsToCoordinates(points));
        expect(polygon.isValid(), isTrue, reason: '$name should be valid');
      });
    });
    test('identifies self-intersection polygon as invalid', (){
      final bowtiePoly = convertToPolygon(convertPointsToCoordinates(bowTie(100)));
      expect(bowtiePoly.isValid(), isFalse, reason: 'bowtie self-intersects, should be invalid');
    });
  });

  group('JTS Area & Perimeter Accuracy', () {
    final shapeSideLength = Random(42).nextDouble() * 100;
    final shapes = <String, List<Point>>{
      'square': square(shapeSideLength),
      'triangle': equilateralTriangle(shapeSideLength),
      'lShape': lShape(shapeSideLength),
    };
    shapes.forEach((name, points) {
      test('clean $name area and perimeter match shoelace formula', () {
        final cleanPoints = resample(points, spacing: 5); // resample base shape
        final cleanCoordinates = convertPointsToCoordinates(cleanPoints);
        final clean = convertToPolygon(cleanCoordinates);
        // tests for clean shape area and perimeter accuracy
        expect(relativeError(clean.getArea(), area(points)), lessThan(1e-9));
        expect(relativeError(clean.getLength(), perimeter(points)), lessThan(1e-9));
      });

      test('noisy $name area and perimeter approximately matches', () {
        final cleanPoints = resample(points, spacing: 5);
        final noisyPoints = addNoise(cleanPoints, NoiseConfig(), Random(42)); // add noise to resampled base shape
        final noisyPolygon = convertToPolygon(convertPointsToCoordinates(noisyPoints));
        expect(relativeError(noisyPolygon.getArea(), area(noisyPoints)), lessThan(1e-9));
        expect(relativeError(noisyPolygon.getLength(), perimeter(noisyPoints)), lessThan(1e-9));
      });
    });
  });

  group('JTS Spatial Relationships', () {
    late jts.Polygon baseSquare;

    setUp(() {
      baseSquare = convertToPolygon(convertPointsToCoordinates(square(100)));
    });

    test('polygon intersects itself', (){
      expect(baseSquare.intersects(baseSquare), isTrue);
    });

    test('polygons with partial overlap intersect', () {
      final shiftedSquare = convertToPolygon(convertPointsToCoordinates([
        Point(100, 100),
        Point(200, 100),
        Point(200, 200),
        Point(100, 200),
        Point(100, 100),
      ]));
      expect(baseSquare.intersects(shiftedSquare), isTrue);
    });

    test('disjoint polygons do not intersect', () {
      final farSquare = convertToPolygon(convertPointsToCoordinates([
        Point(200, 100),
        Point(300, 100),
        Point(300, 200),
        Point(200, 200),
        Point(200, 100),
      ]));
      expect(baseSquare.intersects(farSquare), isFalse);
      expect(baseSquare.disjoint(farSquare), isTrue);
    });
    test('polygons sharing only a boundary touch and intersect', () {
      final adjacentSquare = convertToPolygon(convertPointsToCoordinates([
        Point(100, 0),
        Point(200, 0),
        Point(200, 100),
        Point(100, 100),
        Point(100, 0),
      ]));
      expect(baseSquare.intersects(adjacentSquare), isTrue);
      expect(baseSquare.touches(adjacentSquare), isTrue);
    });
    test('nested polygon is contained within outer polygon', () {
      final nestedSquare = convertToPolygon(convertPointsToCoordinates([
        Point(25, 25),
        Point(75, 25),
        Point(75, 75),
        Point(25, 75),
        Point(25, 25),
      ]));
      expect(baseSquare.contains(nestedSquare), isTrue);
      expect(baseSquare.intersects(nestedSquare), isTrue);
    });
    test('identical polygons are equal', () {
      final identicalSquare = convertToPolygon(convertPointsToCoordinates(square(100)));
      expect(baseSquare.equals(identicalSquare), isTrue);
    });
    // ==== Test is having a type error ====
    // test('returns central point of polygon', () {
    //   final centralCoordinate = jts.Coordinate(50, 50);
    //   expect(baseSquare.getCentroid(), equals(centralCoordinate), reason: 'expected $centralCoordinate');
    // });
  });
}