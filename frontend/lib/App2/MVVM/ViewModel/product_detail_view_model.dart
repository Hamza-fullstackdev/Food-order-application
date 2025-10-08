import 'package:flutter/widgets.dart';
import 'package:frontend/App2/Data/Responses/api_response.dart';
import 'package:frontend/App2/Data/Responses/status.dart';
import 'package:frontend/App2/MVVM/Model/products.dart';
import 'package:frontend/App2/Repository/cart_repo.dart';
import 'package:frontend/App2/Repository/products_repo.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final _productsRepo = ProductsRepo();
  final _cartRepo = CartRepo();

  Map<String, String?> selectedRadio = {};
  Map<String, Set<String>> selectedCheckboxes = {};

  Products _products = Products();
  Products get products => _products;

  ApiResponse _singleProductApiResponse = ApiResponse.notStarted();
  ApiResponse _cartApiResponse = ApiResponse.notStarted();
  ApiResponse get cartApiResponse => _cartApiResponse;

  ApiResponse get singleProductApiResponse => _singleProductApiResponse;

  List<String> invalidGroups = [];
  bool validateSelections(List<VariantGroups> varients) {
    invalidGroups.clear();

    for (var group in varients) {
      if (group.isRequired == true) {
        if (group.maxSelectable == 1) {
          if (selectedRadio[group.name] == null) {
            invalidGroups.add(group.name!);
            return false;
          }
        } else {
          if (selectedCheckboxes[group.name]?.isEmpty ?? true) {
            invalidGroups.add(group.name!);
            return false;
          }
        }
      }
    }
    notifyListeners();
    return invalidGroups.isEmpty;
  }

  Future<void> selectOption(
    List<VariantGroups> varients,
    String productId,
  ) async {
    List<Map<String, dynamic>> selectedOptions = [];

    for (var group in varients) {
      List<String> selectedOptionId = [];
      if (group.maxSelectable == 1) {
        final selectedId = selectedRadio[group.name];
        if (selectedId != null) {
          selectedOptionId.add(selectedId);
        }
      } else {
        final id = selectedCheckboxes[group.name];
        if (id != null && id.isNotEmpty) {
          selectedOptionId.addAll(id);
        }
      }

      if (selectedOptionId.isNotEmpty) {
        selectedOptions.add({
          "variantGroupId": group.sId!,
          "optionIds": selectedOptionId,
        });
      }
    }
    final body = {
      "productId": productId,
      "selectedOptions": selectedOptions,
      "quantity": 1,
    };
    await addToCartItem(body: body);
  }

  Future<void> addToCartItem({required Map<String, dynamic> body}) async {
    _cartApiResponse = ApiResponse.loading();
    notifyListeners();
    _cartApiResponse = await _cartRepo.addItemToCart(body);
    notifyListeners();
  }

  void selectSingleOption(String groupName, String optionId) {
    selectedRadio[groupName] = optionId;
    notifyListeners();
  }

  String? getSelectedOption(String groupName) {
    return selectedRadio[groupName];
  }

  void toggleCheckbox(String groupName, String optionId, bool checked) {
    selectedCheckboxes[groupName] ??= {};
    if (checked) {
      selectedCheckboxes[groupName]!.add(optionId);
    } else {
      selectedCheckboxes[groupName]!.remove(optionId);
    }
    notifyListeners();
  }

  bool isChecked(String groupName, String optionId) {
    return selectedCheckboxes[groupName]?.contains(optionId) ?? false;
  }

  Future<void> getSingleProduct({required String id}) async {
    print("Hllo");
    _singleProductApiResponse = ApiResponse.loading();

    _singleProductApiResponse = await _productsRepo.getSingleProduct(id);
    if (_singleProductApiResponse.status == Status.Success) {
      _products = _singleProductApiResponse.data;
    }
    notifyListeners();
  }
}
