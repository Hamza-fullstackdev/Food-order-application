class AddToCart {
  String? productId;
  List<SelectedOptions>? selectedOptions;
  int? quantity;

  AddToCart({this.productId, this.selectedOptions, this.quantity});

  AddToCart.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    if (json['selectedOptions'] != null) {
      selectedOptions = <SelectedOptions>[];
      json['selectedOptions'].forEach((v) {
        selectedOptions!.add(SelectedOptions.fromJson(v));
      });
    }
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['productId'] = this.productId;
    if (this.selectedOptions != null) {
      data['selectedOptions'] =
          this.selectedOptions!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

class SelectedOptions {
  String? variantGroupId;
  List<String>? optionIds;

  SelectedOptions({this.variantGroupId, this.optionIds});

  SelectedOptions.fromJson(Map<String, dynamic> json) {
    variantGroupId = json['variantGroupId'];
    optionIds = json['optionIds'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variantGroupId'] = this.variantGroupId;
    data['optionIds'] = this.optionIds;
    return data;
  }
}