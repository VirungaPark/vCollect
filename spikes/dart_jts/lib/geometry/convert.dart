import 'dart:io';
import 'dart:convert';
import 'package:vcollect_dart_jts_spike/geometry/point.dart';
import 'package:dart_jts/dart_jts.dart' as jts;

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

List<(double, double)> convertPointsToList(List<Point> polygon){
  List<(double, double)> coords = [];
  for (var i = 0; i < polygon.length; i++) {
    coords.add((polygon[i].x, polygon[i].y));
  }
  return coords;
}
List<(double, double)> convertCoordinatesToList(List<jts.Coordinate> polygon){
  List<(double, double)> coords = [];
  for (var i = 0; i < polygon.length; i++) {
    coords.add((polygon[i].x, polygon[i].y));
  }
  return coords;
}