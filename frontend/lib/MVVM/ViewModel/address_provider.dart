import 'package:flutter/foundation.dart';
import 'package:frontend/MVVM/models/address_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class AddressProvider extends ChangeNotifier {
  bool _isPermissionGranted = false;
  String selectedLabel = "Home";
  Position? _position;
  LatLng? _latLng;
  String _currentAddress = '';

  String? _selectedAddress;
  final List<String> _labelsList = ['Home', 'Work', 'Others'];

  final List<AddressModel> _addressList = [
    AddressModel(
      streetAddress: 'M429 + JPQ,Sahiwal District,Punjab',
      latLng: LatLng(30.6726980, 73.1214628),
      addressType: AddressType.home,
    ),
    AddressModel(
      streetAddress: 'M429 + JPQ,Sahiwal District,Punjab',
      latLng: LatLng(30.670619661673406, 73.09179804238707),
      addressType: AddressType.work,
    ),
  ];

  String get currentAddress => _currentAddress;
  bool get permissionGranted => _isPermissionGranted;
  List<AddressModel> get addressList => _addressList;
  Position get position => _position!;
  LatLng get latLng => _latLng!;
  List<String> get labelList => _labelsList;
  String get selectedAddress => _selectedAddress!;

  void updateLabel(String newLabel) {
    selectedLabel = newLabel;
    notifyListeners();
  }

  Future<void> setAddress(AddressModel address) async {
    _addressList.add(address);
    notifyListeners();
  }

  Future<void> updateAddress(int index, AddressModel address) async {
    _addressList[index] = address;
    notifyListeners();
  }

  Future<void> removeAddress(int index) async {
    _addressList.removeAt(index);
    notifyListeners();
  }

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      _isPermissionGranted = false;
      notifyListeners();
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      _isPermissionGranted = true;
      await _getCurrentPosition();
    }
  }

  Future<void> _getCurrentPosition() async {
    _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _latLng = LatLng(_position!.latitude, _position!.longitude);
    _currentAddress = await getAddressFromLatLng(
      _position!.latitude,
      _position!.longitude,
    );
  }

  Future<void> getSelectedPosition(double latitude, double longitude) async {
    _latLng = LatLng(latitude, longitude);
    _selectedAddress = await getAddressFromLatLng(latitude, longitude);
    notifyListeners();
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      final placement = await placemarkFromCoordinates(latitude, longitude);
      // ignore: unnecessary_null_comparison
      if (placement != null && placement.isNotEmpty) {
        Placemark placemark = placement[0];
        return '${placemark.street},${placemark.subAdministrativeArea},${placemark.administrativeArea}.';
      } else {
        return "No address found";
      }
    } catch (e) {
      return "Error fetching address";
    }
  }
}
