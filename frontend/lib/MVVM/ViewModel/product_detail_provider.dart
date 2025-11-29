import 'package:flutter/material.dart';
import 'package:frontend/MVVM/models/GetProduct_ByCategoryId.dart';

class ProductDetailProvider extends ChangeNotifier {
  final Map<String, String> _isRadio = {};
  int _quantity = 1;

  final Map<String, Set<String>> _selectedSwitches = {};

  
  Map<String, String> get isRadio => _isRadio;
  Map<String, Set<String>> get isSwitch => _selectedSwitches;
  int get quantity => _quantity;

  void updateQuntity(int quantity) {
    _quantity = quantity;
    notifyListeners();
  }

  void setSelectedRadio(String groupId, String selectedId) {
    _isRadio[groupId] = selectedId;
    notifyListeners();
  }

  void setSelectedSwitch(String groupId, String selectedId) {
    if (!_selectedSwitches.containsKey(groupId)) {
      _selectedSwitches[groupId] = {};
    }
    if (_selectedSwitches[groupId]!.contains(selectedId)) {
      _selectedSwitches[groupId]!.remove(selectedId);
    } else {
      _selectedSwitches[groupId]!.add(selectedId);
    }
    notifyListeners();
  }

  List<String> invalidVarients = [];
  bool validateVarients(List<VariantGroups> varients) {
    invalidVarients.clear();
    for (final group in varients) {
      String groupId = group.sId.toString();
      String groupName = group.name ?? "";

      if (group.isRequired == true) {
        if (group.maxSelectable == 1) {
          if (_isRadio[groupId] == null) {
            invalidVarients.add(groupName);
          }
        } else {
          if ((_selectedSwitches[groupId]?.isEmpty ?? true)) {
            invalidVarients.add(groupName);
          }
        }
      }
    }
    notifyListeners();
    return invalidVarients.isEmpty;
  }

  List<Map<String, dynamic>> getSelectedOptions(List<VariantGroups> groups) {
    List<Map<String, dynamic>> result = [];

    for (final group in groups) {
      String groupId = group.sId.toString();
      List<String> optionIds = [];

      if (group.maxSelectable == 1) {
        final id = _isRadio[groupId];
        if (id != null) optionIds.add(id);
      } else {
        final ids = _selectedSwitches[groupId];
        if (ids != null && ids.isNotEmpty) optionIds.addAll(ids);
      }

      if (optionIds.isNotEmpty) {
        result.add({"variantGroupId": group.sId, "optionIds": optionIds});
      }
    }

    return result;
  }
}