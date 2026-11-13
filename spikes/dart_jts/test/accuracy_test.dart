import 'dart:math' show Random;
import 'package:vector_math/vector_math_64.dart';
import 'package:test/test.dart';

import 'package:vcollect_dart_jts_spike/geometry/shapes.dart';
import 'package:vcollect_dart_jts_spike/geometry/measure.dart';
import 'package:vcollect_dart_jts_spike/geometry/point.dart';
import 'package:vcollect_dart_jts_spike/generator/resample.dart';
import 'package:vcollect_dart_jts_spike/generator/noise.dart';
import 'package:vcollect_dart_jts_spike/pipelines/pipeline.dart';



void main(){
  group('clean shapes (zero noise)', () {
    final shapes = <String, List<Point>>{
      'square': square(100),
      'triangle': equilateralTriangle(100),
      'lShape': lShape(100),
      // 'circle r=100': circle(100, 10) fix circle
    };
    shapes.forEach((name, points) {
      test(name, (){
        final trace = resample(points, spacing: 5);
        final result = runPipeline(trace);

        expect(result.isValid, isTrue);
        expect(relativeError(result.area, area(points)), lessThan(1e-9));
        expect(relativeError(result.perimeter, perimeter(points)), lessThan(1e-9));
      });
    });
  });

  // what is the real purpose of this test?
  // a noisy perimeter >= clean perimeter, noisy area >= clean area
  // an invalid noisy perimeter >= repaired perimeter, invalid noisy area >= repaired area
  group('noisy shapes', () {
    final shapes = <String, List<Point>>{
      'square': square(100),
      'triangle': equilateralTriangle(100),
      'lShape': lShape(100),
    };
    for (final seed in [1, 2, 3]) {
      shapes.forEach((name, points) {
        final outline = shapes[name];
        final trueArea = area(outline!);
        final truePerimeter = perimeter(outline);
        test('$name seed=$seed', () {
          final clean = resample(points, spacing: 5);
          final noisy = addNoise(clean, NoiseConfig(), Random(seed));

          final noisyTrueArea = area(noisy);
          final noisyTruePerimeter = perimeter(noisy);

          final result = runPipeline(noisy, repair: true);
          final areaError = relativeError(result.area, noisyTrueArea);
          final perimeterError = relativeError(result.perimeter, noisyTruePerimeter);

          print('seed $seed: valid=${result.isValid} '
              'areaError=${(areaError * 100).toStringAsFixed(3)}% '
              'perimeterError=${(perimeterError * 100).toStringAsFixed(2)}% '
              'build=${result.buildTime.inMicroseconds}microseconds '
              'validateTime=${result.validateTime.inMicroseconds}microseconds');

          expect(areaError, lessThan(0.05));
          expect(perimeterError, lessThan(0.25));
          expect(result.isValid, isTrue);
        });
      });
    }
  });
}