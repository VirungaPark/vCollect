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

Future<void> main() async{
  final result = await Process.run('dart', ['test'], runInShell: true);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
  exit(result.exitCode);
}