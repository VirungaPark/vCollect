import 'dart:math';
import 'package:vcollect_dart_jts_spike/geometry/point.dart';

class NoiseConfig {
  final double jitter;        // std dev, meters (e.g. 1.5)
  final double driftStep;     // random walk step, meters (e.g. 0.2)
  final double driftDecay;    // 0..1, pulls drift back toward 0 (e.g. 0.98)
  final double outlierProb;   // per point (e.g. 0.01)
  final double pauseProb;     // per point (e.g. 0.02)
  const NoiseConfig({
    this.jitter = 1.5, this.driftStep = 0.2, this.driftDecay = 0.98,
    this.outlierProb = 0.01, this.pauseProb = 0.02,
  });
}

double _gauss(Random r) {
  // Box-Muller
  final u1 = 1 - r.nextDouble(), u2 = r.nextDouble();
  return sqrt(-2 * log(u1)) * cos(2 * pi * u2);
}

List<NoisyPoint> addNoise(List<Point> clean, NoiseConfig c, Random rng) {
  final out = <NoisyPoint>[];
  var dx = 0.0, dy = 0.0;
  for (final p in clean) {
    dx = dx * c.driftDecay + _gauss(rng) * c.driftStep;
    dy = dy * c.driftDecay + _gauss(rng) * c.driftStep;

    var nx = p.x + dx + _gauss(rng) * c.jitter;
    var ny = p.y + dy + _gauss(rng) * c.jitter;
    var acc = 3 + rng.nextDouble() * 3;

    if (rng.nextDouble() < c.outlierProb) {
      final ang = rng.nextDouble() * 2 * pi;
      final dist = 10 + rng.nextDouble() * 20;
      nx += cos(ang) * dist;
      ny += sin(ang) * dist;
      acc = 20 + rng.nextDouble() * 30;   // outliers report worse accuracy
    }

    final np = NoisyPoint(nx, ny, acc);
    out.add(np);
    if (rng.nextDouble() < c.pauseProb) out.add(np); // duplicate = pause
  }
  return out;
}