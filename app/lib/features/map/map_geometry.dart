import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'data/sample_field.dart';

/// The smallest box holding every corner of [fields], or null when there
/// are none.
LatLngBounds? boundsOf(Iterable<SampleField> fields) {
  final points = [for (final field in fields) ...field.ring];
  return points.isEmpty ? null : LatLngBounds.fromPoints(points);
}

/// Where to put a field's label: the average of its corners.
///
/// Fine for the convex sample fields. Real fields can be concave, where
/// this point may fall outside; switch to a pole-of-inaccessibility
/// search then.
LatLng labelPointOf(List<LatLng> ring) {
  assert(ring.isNotEmpty, 'A field needs at least one corner');
  var lat = 0.0;
  var lon = 0.0;
  for (final point in ring) {
    lat += point.latitude;
    lon += point.longitude;
  }
  return LatLng(lat / ring.length, lon / ring.length);
}
