import 'package:vcollect_dart_jts_spike/geometry/point.dart';
import 'dart:io';
import 'dart:convert';

void writePointsCsv(String path, List<Point> pts, {double hz = 1.0}) {
  final sb = StringBuffer('timestamp,x,y,accuracy\n');
  for (var i = 0; i < pts.length; i++) {
    final p = pts[i];
    final acc = p is NoisyPoint ? p.accuracy : 1.0; // honest small value for clean points
    sb.writeln('${i / hz},${p.x},${p.y},$acc');
  }
  final file = File(path);
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(sb.toString());
}

void writeTruthJson(String path, Map<String, Object> truth) {
  File(path).writeAsStringSync(const JsonEncoder.withIndent('  ').convert(truth));
}