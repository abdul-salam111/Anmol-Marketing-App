class Order {
  int? orderId;
  int totalProducts;
  double totalAmount;
  String timestamp;
  Order({this.orderId, required this.totalProducts, required this.totalAmount, required this.timestamp});

  Map<String, dynamic> toMap() => {
    'orderId': orderId,
    'totalProducts': totalProducts,
    'totalAmount': totalAmount,
    'timestamp': timestamp,
  };
}

class CompanyOrder {
  int? companyOrderId;
  int? orderId;
  String companyId;
  String companyName;
  double companyTotal;
  CompanyOrder({this.companyOrderId, this.orderId, required this.companyId, required this.companyName, required this.companyTotal});

  Map<String, dynamic> toMap() => {
    'companyOrderId': companyOrderId,
    'orderId': orderId,
    'companyId': companyId,
    'companyName': companyName,
    'companyTotal': companyTotal,
  };
}

class OrderItem {
  int? itemId;
  int? companyOrderId;
  String productId;
  String productName;
  double tradePrice;
  int quantity;
  double productTotal;
  OrderItem({this.itemId, this.companyOrderId, required this.productId, required this.productName, required this.tradePrice, required this.quantity, required this.productTotal});

  Map<String, dynamic> toMap() => {
    'itemId': itemId,
    'companyOrderId': companyOrderId,
    'productId': productId,
    'productName': productName,
    'tradePrice': tradePrice,
    'quantity': quantity,
    'productTotal': productTotal,
  };
} 