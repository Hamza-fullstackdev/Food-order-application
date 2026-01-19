import 'package:flutter/material.dart';
import 'package:frontend/MVVM/models/cart_model.dart';

class DetailController extends ChangeNotifier {
  final Map<String, Options?> _selectedVariants = {};
  final Map<String, List<Options>> _selectedOptionalVariants = {};

  Map<String, Options?> get selectedVariants => _selectedVariants;
  Map<String, List<Options>> get selectedOptionalVariants =>
      _selectedOptionalVariants;

  /// Initialize variants (call this in initState of screen)
  void initVariants(List<VariantGroups> variants) {
    for (var variant in variants) {
      if (variant.options == null || variant.options!.isEmpty) {
        continue;
      }
      if (variant.name == "Size") {
        _selectedVariants[variant.name ?? ''] =
            variant.options!.isNotEmpty ? variant.options![0] : null;
      } else {
        _selectedOptionalVariants[variant.name ?? ''] = [];
      }
    }
    notifyListeners();
  }

  bool isSizeSelected() {
    return _selectedVariants.containsKey('Size') &&
        _selectedVariants['Size'] != null;
  }

  bool canSelectMore(String variantName) {
    return (_selectedOptionalVariants[variantName]?.length ?? 0) < 2;
  }

  void setSelectedRadioVaraints(Options? value, VariantGroups variant) {
    if (value != null) {
      _selectedVariants[variant.name ?? ''] = value;
      notifyListeners();
    }
  }

  void setCheckBoxVariants(bool value, VariantGroups variant, Options option) {
    final variantName = variant.name ?? '';
    if (value && canSelectMore(variantName)) {
      _selectedOptionalVariants[variantName] ??= [];
      _selectedOptionalVariants[variantName]!.add(option);
    } else if (!value) {
      _selectedOptionalVariants[variantName]?.remove(option);
    }
    notifyListeners();
  }
}