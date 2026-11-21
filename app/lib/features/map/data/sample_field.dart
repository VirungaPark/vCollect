import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';

/// A field outline to draw on the map.
///
/// Placeholder until fields come from the local database; only what the
/// map needs to draw and label the field.
class SampleField {
  const SampleField({required this.ring, this.name, this.crop});

  /// Corners in order, without repeating the first corner at the end.
  final List<LatLng> ring;
  final String? name;
  final String? crop;
}

/// Reads the polygon features of a GeoJSON FeatureCollection.
///
/// Features that are not polygons, or have fewer than three distinct
/// corners, are skipped rather than failing the whole map. Holes are
/// ignored. Throws [FormatException] when the text is not a
/// FeatureCollection.
List<SampleField> parseFieldsGeoJson(String source) {
  final json = jsonDecode(source);
  if (json is! Map<String, dynamic> ||
      json['type'] != 'FeatureCollection' ||
      json['features'] is! List) {
    throw const FormatException('Expected a GeoJSON FeatureCollection');
  }

  final fields = <SampleField>[];
  for (final feature in json['features'] as List) {
    if (feature case {
      'geometry': {'type': 'Polygon', 'coordinates': [final List outer, ...]},
    }) {
      final ring = _parseRing(outer);
      if (ring == null) continue;
      final properties = feature['properties'];
      fields.add(
        SampleField(
          ring: ring,
          name: properties is Map ? properties['name'] as String? : null,
          crop: properties is Map ? properties['crop'] as String? : null,
        ),
      );
    }
  }
  return fields;
}

List<LatLng>? _parseRing(List coordinates) {
  final points = <LatLng>[];
  for (final position in coordinates) {
    // GeoJSON order is longitude, latitude.
    if (position case [final num lon, final num lat, ...]) {
      points.add(LatLng(lat.toDouble(), lon.toDouble()));
    } else {
      return null;
    }
  }
  if (points.length > 1 && points.first == points.last) points.removeLast();
  return points.length >= 3 ? points : null;
}

/// Where the map gets its fields from.
abstract interface class FieldsSource {
  Future<List<SampleField>> load();
}

/// Reads the bundled synthetic fields.
class AssetFieldsSource implements FieldsSource {
  const AssetFieldsSource({this.asset = 'assets/map/sample_fields.geojson'});

  final String asset;

  @override
  Future<List<SampleField>> load() async =>
      parseFieldsGeoJson(await rootBundle.loadString(asset));
}
