import 'dart:io';
import 'dart:convert';
import 'package:vcollect_dart_jts_spike/geometry/point.dart';
import 'package:dart_jts/dart_jts.dart' as jts;

List<jts.Coordinate> readCsv(String path){
  final lines = File(path).readAsLinesSync().skip(1); // skip the header line
  final coords = <jts.Coordinate>[];
  for(final line in lines){
    if (line.trim().isNotEmpty){
      final f = line.split(',');
      coords.add(jts.Coordinate(double.parse(f[1]), double.parse(f[2])));
    }
  }
  return coords;
}

List<jts.Coordinate> convertPointsToCoordinates(List<Point> points){
  final coords = <jts.Coordinate>[];
  for(var i = 0; i < points.length; i++){
    coords.add(jts.Coordinate(points[i].x, points[i].y));
  }
  return coords;
}

// Convert a list of coordinates into a LinearRing polygon.
// A LinearRing enforces closed boundaries, 0 or at least 4 points.
jts.Polygon convertToPolygon(List<jts.Coordinate> coords){
  final gf = jts.GeometryFactory.defaultPrecision();
  final ring = [...coords]; // create a copy of coords
  // if polygon is not closed, close it
  if (ring.first.x != ring.last.x || ring.first.y != ring.last.y){
    ring.add(ring.first);
  }
  return gf.createPolygon(gf.createLinearRing(ring), null);
}