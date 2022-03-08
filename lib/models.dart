class ShopCart {

  late final int? ItemId;

  final String? ItemName;

  final String? ItemUrduName;
  final String? TradePrice;

  ShopCart({
    required this.ItemId ,

    required this.ItemName,

    required this.ItemUrduName,
    required this.TradePrice
  });

  ShopCart.fromMap(Map<dynamic , dynamic>  res)
      : ItemId = res['ItemId'],

        ItemName = res["ItemName"],

        ItemUrduName = res["ItemUrduName"],
        TradePrice = res["TradePrice"];

  Map<String, Object?> toMap(){
    return {
      'ItemId' : ItemId ,

      'ItemName' :ItemName,



      'ItemUrduName' : ItemUrduName,
      'TradePrice' : TradePrice,
    };
  }
}