import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:vcollect/features/map/data/sample_field.dart';

String _collection(List<Map<String, Object?>> features) =>
    jsonEncode({'type': 'FeatureCollection', 'features': features});

Map<String, Object?> _polygon(
  List<List<num>> ring, {
  Map<String, Object?>? properties,
}) => {
  'type': 'Feature',
  'properties': properties,
  'geometry': {
    'type': 'Polygon',
    'coordinates': [ring],
  },
};

void main() {
  group('parseFieldsGeoJson', () {
    test('reads corners as latitude/longitude and drops the closing one', () {
      final fields = parseFieldsGeoJson(
        _collection([
          _polygon(
            [
              [1, 2],
              [3, 2],
              [3, 4],
              [1, 2],
            ],
            properties: {'name': 'Field 1', 'crop': 'Cocoa'},
          ),
        ]),
      );

      expect(fields, hasLength(1));
      expect(fields.single.ring, const [
        LatLng(2, 1),
        LatLng(2, 3),
        LatLng(4, 3),
      ]);
      expect(fields.single.name, 'Field 1');
      expect(fields.single.crop, 'Cocoa');
    });

    test('skips features that are not polygons', () {
      final fields = parseFieldsGeoJson(
        _collection([
          {
            'type': 'Feature',
            'properties': {'name': 'Path'},
            'geometry': {
              'type': 'LineString',
              'coordinates': [
                [0, 0],
                [1, 1],
              ],
            },
          },
        ]),
      );

      expect(fields, isEmpty);
    });

    test('skips rings with fewer than three distinct corners', () {
      final fields = parseFieldsGeoJson(
        _collection([
          _polygon([
            [0, 0],
            [1, 1],
            [0, 0],
          ]),
        ]),
      );

      expect(fields, isEmpty);
    });

    test('skips rings with malformed positions', () {
      final fields = parseFieldsGeoJson(
        _collection([
          _polygon([
            [0, 0],
            [1],
            [1, 1],
            [0, 1],
          ]),
        ]),
      );

      expect(fields, isEmpty);
    });

    test('keeps a field whose name and crop are missing', () {
      final fields = parseFieldsGeoJson(
        _collection([
          _polygon([
            [0, 0],
            [1, 0],
            [1, 1],
          ]),
        ]),
      );

      expect(fields.single.name, isNull);
      expect(fields.single.crop, isNull);
    });

    test('rejects text that is not a FeatureCollection', () {
      expect(
        () => parseFieldsGeoJson('{"type": "Feature"}'),
        throwsFormatException,
      );
    });
  });

  test('the bundled sample has two named fields with crops', () async {
    TestWidgetsFlutterBinding.ensureInitialized();

    final fields = await const AssetFieldsSource().load();

    expect(fields.map((f) => f.name), ['Field 1', 'Field 2']);
    expect(fields.every((f) => f.crop != null), isTrue);
  });
}
