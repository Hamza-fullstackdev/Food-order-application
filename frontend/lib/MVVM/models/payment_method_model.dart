class PaymentMethodsModel {
  String cardType;
  String cardLogo;

  PaymentMethodsModel({
    required this.cardType,
    required this.cardLogo,
  });

  factory PaymentMethodsModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodsModel(
      cardType: json['cardType'] ?? '',
      cardLogo: json['cardLogo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardType': cardType,
      'cardLogo': cardLogo,
    };
  }
}