
class CardModel {
  final String name;
  
  final String cardType;
  final String cardNum;
  final String expDate;
  final String cvcNum;

  CardModel({
    required this.name,
    required this.cardNum,
    required this.expDate,
    required this.cvcNum,
    required this.cardType,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      name: json['name'] ?? '',
      cardNum: json['card_num'] ?? '',
      expDate: json['exp_date'] ?? '',
      cvcNum: json['cvc_num'] ?? '',
      cardType: json['cardType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'card_num': cardNum,
      'exp_date': expDate,
      'cvc_num': cvcNum,
      'cardType': cardType,
    };
  }


}