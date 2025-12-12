import 'package:flutter/material.dart';
import 'package:frontend/MVVM/models/GetProduct_ByCategoryId.dart';

class ProductDetailProvider extends ChangeNotifier {
  int _quantity = 1;
  int _totalPrice = 0;
  int _basePrice = 0;

  final Map<String, String> _isRadio = {};
  final Map<String, Set<String>> _selectedSwitches = {};

  Map<String, String> get isRadio => _isRadio;
  Map<String, Set<String>> get isSwitch => _selectedSwitches;

  int get quantity => _quantity;
  int get totalPrice => _totalPrice;
  int get basePrice => _basePrice;
  List<String> invalidVarients = [];

  List<VariantGroups>? groupCahce;

  void updateQuntity(int quantity) {
    _quantity = quantity;
    calculatePrice(groupCahce!);
  }

  void setSelectedRadio(
    String groupId,
    String selectedId,
    List<VariantGroups> variantGroups,
    int updatedPrice,
  ) {
    groupCahce = variantGroups;
    _isRadio[groupId] = selectedId;
    calculatePrice(variantGroups);
  }

  void setSelectedSwitch(
    String groupId,
    String selectedId,
    List<VariantGroups> variantGroups,
    int updatedPrice,
  ) {
    groupCahce = variantGroups;

    _selectedSwitches.putIfAbsent(groupId, () => {});

    if (_selectedSwitches[groupId]!.contains(selectedId)) {
      _selectedSwitches[groupId]!.remove(selectedId);
    } else {
      _selectedSwitches[groupId]!.add(selectedId);
    }
    calculatePrice(variantGroups);
  }

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

  void calculatePrice(List<VariantGroups>? groups) {
    if (groups == null) return;

    int basePrice = 0;
    int totalPrice = 0;

    for (var currentVarient in groups) {
      final groupId = currentVarient.sId!;

      if (currentVarient.maxSelectable! == 1) {
        final selectedId = _isRadio[groupId];

        if (selectedId != null) {
          final option = currentVarient.options!.firstWhere(
            (op) => op.sId! == selectedId,
          );

          if (currentVarient.isRequired!) {
            basePrice = option.price ?? 0;
          } else {
            totalPrice = totalPrice + (option.price ?? 0);
          }
        }
      } else {
        final selectedIds = _selectedSwitches[groupId] ?? {};

        for (var item in selectedIds) {
          final options = currentVarient.options!.firstWhere(
            (op) => op.sId! == item,
          );
          totalPrice = totalPrice + options.price!;
        }
      }
    }
    _basePrice = basePrice;
    _totalPrice = (_basePrice + totalPrice) * quantity;

    notifyListeners();
  }
}
