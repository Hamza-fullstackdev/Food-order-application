import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressModel {
  final String streetAddress;
  final AddressType? addressType;
  final LatLng latLng;

  const AddressModel({
    required this.streetAddress,
    this.addressType,
    required this.latLng,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      streetAddress: json['streetAddress'] as String,
      addressType: AddressTypeExtension.fromString(
        json['addressType'] as String,
      ),
      latLng: LatLng(
        (json['latitude'] as num).toDouble(),
        (json['longitude'] as num).toDouble(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'streetAddress': streetAddress,
      'addressType': addressType!.name,
      'latitude': latLng.latitude,
      'longitude': latLng.longitude,
    };
  }
}

enum AddressType { home, work, other }

extension AddressTypeExtension on AddressType {
  String get name {
    switch (this) {
      case AddressType.home:
        return 'Home';
      case AddressType.work:
        return 'Work';
      case AddressType.other:
        return 'Other';
    }
  }

  static AddressType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'home':
        return AddressType.home;
      case 'work':
        return AddressType.work;
      default:
        return AddressType.other;
    }
  }
}
