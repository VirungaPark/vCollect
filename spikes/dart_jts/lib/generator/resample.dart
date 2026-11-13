import 'dart:math';
import 'package:vcollect_dart_jts_spike/geometry/point.dart';
import 'package:vcollect_dart_jts_spike/geometry/measure.dart';

// resample a list of points to a new spacing
List<Point> resample(List<Point> outline, {double spacing = 1.3}) {
  final out = <Point>[];
  for (var i = 0; i < outline.length; i++) {
    final a = outline[i], b = outline[(i + 1) % outline.length];
    final len = sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2));
    final n = max(1, (len / spacing).round());
    for (var j = 0; j < n; j++) {
      final t = j / n;
      out.add(Point(a.x + (b.x - a.x) * t, a.y + (b.y - a.y) * t));
    }
  }
  return out;
}
// not accurate when target count is too small relative to the outlines perimeter
List<Point> resampleCount(List<Point> outline, int targetCount){
  final totalPerimeter = perimeter(outline);
  final targetSpacing = totalPerimeter / targetCount;
  return resample(outline, spacing: targetSpacing);
}