import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteResponse {
  final List<RouteFeature> features;

  RouteResponse({required this.features});

  factory RouteResponse.fromJson(Map<String, dynamic> json) {
    return RouteResponse(
      features: (json['features'] as List)
          .map((e) => RouteFeature.fromJson(e))
          .toList(),
    );
  }
}

class RouteFeature {
  final RouteGeometry geometry;
  final RouteProperties properties;

  RouteFeature({required this.geometry, required this.properties});

  factory RouteFeature.fromJson(Map<String, dynamic> json) {
    return RouteFeature(
      geometry: RouteGeometry.fromJson(json['geometry']),
      properties: RouteProperties.fromJson(json['properties']),
    );
  }
}

class RouteGeometry {
  final List<LatLng> points;

  RouteGeometry({required this.points});

  factory RouteGeometry.fromJson(Map<String, dynamic> json) {
    final coords = json['coordinates'] as List;

    return RouteGeometry(
      points: coords
          .map<LatLng>((p) => LatLng(p[1], p[0])) // swap!
          .toList(),
    );
  }
}

class RouteProperties {
  final RouteSummary summary;
  final List<RouteSegment> segments;

  RouteProperties({required this.summary, required this.segments});

  factory RouteProperties.fromJson(Map<String, dynamic> json) {
    return RouteProperties(
      summary: RouteSummary.fromJson(json['summary']),
      segments: (json['segments'] as List)
          .map((e) => RouteSegment.fromJson(e))
          .toList(),
    );
  }
}

class RouteSummary {
  final double distance; // meters
  final double duration; // seconds

  RouteSummary({required this.distance, required this.duration});

  factory RouteSummary.fromJson(Map<String, dynamic> json) {
    return RouteSummary(
      distance: (json['distance'] as num).toDouble(),
      duration: (json['duration'] as num).toDouble(),
    );
  }

  String get distanceKm => (distance / 1000).toStringAsFixed(2);
  int get durationMin => (duration / 60).ceil();
}

class RouteSegment {
  final double distance;
  final double duration;
  final List<RouteStep> steps;

  RouteSegment({
    required this.distance,
    required this.duration,
    required this.steps,
  });

  factory RouteSegment.fromJson(Map<String, dynamic> json) {
    return RouteSegment(
      distance: (json['distance'] as num).toDouble(),
      duration: (json['duration'] as num).toDouble(),
      steps: (json['steps'] as List).map((e) => RouteStep.fromJson(e)).toList(),
    );
  }
}

class RouteStep {
  final String instruction;
  final double distance;
  final double duration;
  final int type;

  RouteStep({
    required this.instruction,
    required this.distance,
    required this.duration,
    required this.type,
  });

  factory RouteStep.fromJson(Map<String, dynamic> json) {
    return RouteStep(
      instruction: json['instruction'],
      distance: (json['distance'] as num).toDouble(),
      duration: (json['duration'] as num).toDouble(),
      type: json['type'],
    );
  }
}
