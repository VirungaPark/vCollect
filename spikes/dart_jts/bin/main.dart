import 'dart:math';
import 'dart:io';
import 'package:vcollect_dart_jts_spike/geometry/point.dart';
import 'package:vcollect_dart_jts_spike/geometry/shapes.dart';
import 'package:vcollect_dart_jts_spike/geometry/measure.dart';
import 'package:vcollect_dart_jts_spike/generator/noise.dart';
import 'package:vcollect_dart_jts_spike/generator/resample.dart';
import 'package:vcollect_dart_jts_spike/io/write.dart';
import 'package:vcollect_dart_jts_spike/io/convert.dart';
import 'package:vcollect_dart_jts_spike/pipelines/pipeline.dart';
import 'package:dart_jts/dart_jts.dart' as jts;


// convert a list of type points to a list of tuples (used for debugging ie pasting into Desmos)
List<(double, double)> convertToList(List<Point> polygon){
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
Future<void> main() async{
  final result = await Process.run('dart', ['test'], runInShell: true);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
  exit(result.exitCode);
}