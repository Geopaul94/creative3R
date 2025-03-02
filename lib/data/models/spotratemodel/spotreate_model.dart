class SpotRate {
  bool success;
  Info info;
  String message;

  SpotRate({
    required this.success,
    required this.info,
    required this.message,
  });

  factory SpotRate.fromJson(Map<String, dynamic> json) {
    return SpotRate(
      success: json['success'],
      info: Info.fromJson(json['info']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'info': info.toJson(),
      'message': message,
    };
  }
}

class Info {
  String id;
  String createdBy;
  double silverAskSpread;
  double silverBidSpread;
  double goldAskSpread;
  double goldBidSpread;
  double copperAskSpread;
  double copperBidSpread;
  double platinumAskSpread;
  double platinumBidSpread;
  double goldLowMargin;
  double goldHighMargin;
  double silverLowMargin;
  double silverHighMargin;
  double copperLowMargin;
  double copperHighMargin;
  double platinumLowMargin;
  double platinumHighMargin;
  List<Commodity> commodities;

  Info({
    required this.id,
    required this.createdBy,
    required this.silverAskSpread,
    required this.silverBidSpread,
    required this.goldAskSpread,
    required this.goldBidSpread,
    required this.copperAskSpread,
    required this.copperBidSpread,
    required this.platinumAskSpread,
    required this.platinumBidSpread,
    required this.goldLowMargin,
    required this.goldHighMargin,
    required this.silverLowMargin,
    required this.silverHighMargin,
    required this.copperLowMargin,
    required this.copperHighMargin,
    required this.platinumLowMargin,
    required this.platinumHighMargin,
    required this.commodities,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    var commoditiesList = json['commodities'] as List;
    List<Commodity> commodities =
        commoditiesList.map((e) => Commodity.fromJson(e)).toList();

    return Info(
      id: json['_id'],
      createdBy: json['createdBy'],
      silverAskSpread: json['silverAskSpread'].toDouble(),
      silverBidSpread: json['silverBidSpread'].toDouble(),
      goldAskSpread: json['goldAskSpread'].toDouble(),
      goldBidSpread: json['goldBidSpread'].toDouble(),
      copperAskSpread: json['copperAskSpread'].toDouble(),
      copperBidSpread: json['copperBidSpread'].toDouble(),
      platinumAskSpread: json['platinumAskSpread'].toDouble(),
      platinumBidSpread: json['platinumBidSpread'].toDouble(),
      goldLowMargin: json['goldLowMargin'].toDouble(),
      goldHighMargin: json['goldHighMargin'].toDouble(),
      silverLowMargin: json['silverLowMargin'].toDouble(),
      silverHighMargin: json['silverHighMargin'].toDouble(),
      copperLowMargin: json['copperLowMargin'].toDouble(),
      copperHighMargin: json['copperHighMargin'].toDouble(),
      platinumLowMargin: json['platinumLowMargin'].toDouble(),
      platinumHighMargin: json['platinumHighMargin'].toDouble(),
      commodities: commodities,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'createdBy': createdBy,
      'silverAskSpread': silverAskSpread,
      'silverBidSpread': silverBidSpread,
      'goldAskSpread': goldAskSpread,
      'goldBidSpread': goldBidSpread,
      'copperAskSpread': copperAskSpread,
      'copperBidSpread': copperBidSpread,
      'platinumAskSpread': platinumAskSpread,
      'platinumBidSpread': platinumBidSpread,
      'goldLowMargin': goldLowMargin,
      'goldHighMargin': goldHighMargin,
      'silverLowMargin': silverLowMargin,
      'silverHighMargin': silverHighMargin,
      'copperLowMargin': copperLowMargin,
      'copperHighMargin': copperHighMargin,
      'platinumLowMargin': platinumLowMargin,
      'platinumHighMargin': platinumHighMargin,
      'commodities': commodities.map((e) => e.toJson()).toList(),
    };
  }
}

class Commodity {
  String metal;
  int purity;
  int unit;
  String weight;
  double buyPremium;
  double sellPremium;
  double buyCharge;
  double sellCharge;
  String id;

  Commodity({
    required this.metal,
    required this.purity,
    required this.unit,
    required this.weight,
    required this.buyPremium,
    required this.sellPremium,
    required this.buyCharge,
    required this.sellCharge,
    required this.id,
  });

  factory Commodity.fromJson(Map<String, dynamic> json) {
    return Commodity(
      metal: json['metal'],
      purity: json['purity'],
      unit: json['unit'],
      weight: json['weight'],
      buyPremium: json['buyPremium'].toDouble(),
      sellPremium: json['sellPremium'].toDouble(),
      buyCharge: json['buyCharge'].toDouble(),
      sellCharge: json['sellCharge'].toDouble(),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metal': metal,
      'purity': purity,
      'unit': unit,
      'weight': weight,
      'buyPremium': buyPremium,
      'sellPremium': sellPremium,
      'buyCharge': buyCharge,
      'sellCharge': sellCharge,
      '_id': id,
    };
  }
}
