import 'package:dart_jts/dart_jts.dart' as jts;
import 'package:vcollect_dart_jts_spike/geometry/point.dart';

class SpikeResult {
  final double area, perimeter;
  final bool isValid, repaired;
  final Duration buildTime, validateTime, repairTime, measureTime;
  SpikeResult(this.area,
      this.perimeter,
      this.isValid,
      this.repaired,
      this.buildTime,
      this.validateTime,
      this.repairTime,
      this.measureTime);
}

SpikeResult runPipeline(List<Point> points, {bool repair = false}) {
  final sw = Stopwatch()..start(); // start stopwatch
  final gf = jts.GeometryFactory.defaultPrecision(); // create geometry factory

  final coords = [for (final p in points) jts.Coordinate(p.x, p.y)];
  if (coords.first.x != coords.last.x || coords.first.y != coords.last.y) {
    coords.add(jts.Coordinate.fromCoordinate(coords.first));
  }
  jts.Geometry geom = gf.createPolygon(gf.createLinearRing(coords), null);
  final build = sw.elapsed; sw.reset();

  var valid = geom.isValid();
  final validate = sw.elapsed; sw.reset();

  var repaired = false;
  if (!valid && repair) {
    geom = geom.buffer(0);
    valid = geom.isValid();
    repaired = true;
  }
  final repairT = sw.elapsed; sw.reset();

  final area = geom.getArea(), len = geom.getLength();
  return SpikeResult(area, len, valid, repaired, build, validate, repairT, sw.elapsed);
}
