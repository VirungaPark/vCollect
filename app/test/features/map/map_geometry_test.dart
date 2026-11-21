import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:vcollect/features/map/data/sample_field.dart';
import 'package:vcollect/features/map/map_geometry.dart';

void main() {
  group('boundsOf', () {
    test('covers every corner of every field', () {
      final bounds = boundsOf(const [
        SampleField(ring: [LatLng(0, 0), LatLng(0, 1), LatLng(1, 1)]),
        SampleField(ring: [LatLng(-2, -3), LatLng(-1, -3), LatLng(-1, -2)]),
      ])!;

      expect(bounds.south, -2);
      expect(bounds.west, -3);
      expect(bounds.north, 1);
      expect(bounds.east, 1);
    });

    test('is null when there are no fields', () {
      expect(boundsOf(const []), isNull);
    });
  });

  test('labelPointOf averages the corners', () {
    final point = labelPointOf(const [
      LatLng(0, 0),
      LatLng(0, 2),
      LatLng(2, 2),
      LatLng(2, 0),
    ]);

    expect(point, const LatLng(1, 1));
  });
}
