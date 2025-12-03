import 'package:flutter/material.dart';
import 'package:frontend/MVVM/models/GetProduct_ByCategoryId.dart';

class ProductDetailProvider extends ChangeNotifier {
  int _quantity = 1;
  int _price = 0;

  final Map<String, String> _isRadio = {};
  final Map<String, Set<String>> _selectedSwitches = {};

  Map<String, String> get isRadio => _isRadio;
  Map<String, Set<String>> get isSwitch => _selectedSwitches;

  int get quantity => _quantity;
  int get price => _price;

  void updateQuntity(int quantity) {
    _quantity = quantity;

    notifyListeners();
  }

  void setSelectedRadio(
    String groupId,
    String selectedId,
    List<VariantGroups> variantGroups,
    int updatedPrice
  ) {
    _isRadio[groupId] = selectedId;
    updatePrice(variantGroups,updatedPrice);
    notifyListeners();
  }

  void updatePrice(List<VariantGroups> variantGroups,int updatedPrice) {
    for (var item in variantGroups) {
      if (item.isRequired!) {
        _price = _price == 0 ? item.options![0].price! : updatedPrice;
      }
    }
    notifyListeners();
  }

  void setSelectedSwitch(
    String groupId,
    String selectedId,
    List<VariantGroups> variantGroups,
    int updatedPrice
  ) {
    if (!_selectedSwitches.containsKey(groupId)) {
      _selectedSwitches[groupId] = {};
    }
    updatePrice(variantGroups,updatedPrice);

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

      if (group.isRequired == true) {
        if (group.maxSelectable == 1) {
          if (_isRadio[groupId] == null) {
            invalidVarients.add(groupId);
          }
        } else {
          if ((_selectedSwitches[groupId]?.isEmpty ?? true)) {
            invalidVarients.add(groupId);
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
