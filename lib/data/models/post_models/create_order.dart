class OrderModel {
  final String orderId;
  final String orderDate;
  final double grandTotal;
  final int totalProducts;
  final List<OrderCompany> companies;

  OrderModel({
    required this.orderId,
    required this.orderDate,
    required this.grandTotal,
    required this.totalProducts,
 
    required this.companies,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      orderDate: json['orderDate'],
      grandTotal: json['grandTotal'],
      totalProducts: json['totalProducts'],
   
      companies: [], // This would be populated separately
    );
  }
}

class OrderCompany {
  final int companyId;
  final String companyName;
  final String companyLogo;
  final double companyTotal;
  final int totalProducts;
  final List<OrderProduct> products;

  OrderCompany({
    required this.companyId,
    required this.companyName,
    required this.companyLogo,
    required this.companyTotal,
    required this.totalProducts,
    required this.products,
  });

  factory OrderCompany.fromJson(Map<String, dynamic> json) {
    return OrderCompany(
      companyId: json['companyId'],
      companyName: json['companyName'],
      companyLogo: json['companyLogo'],
      companyTotal: json['companyTotal'],
      totalProducts: json['totalProducts'],
      products: [], // This would be populated separately
    );
  }
}

class OrderProduct {
  final int productId;
  final String productName;
  final String productLogo;
  final String pack;
  final double tradePrice;
  final int quantity;
  final double totalPrice;

  OrderProduct({
    required this.productId,
    required this.productName,
    required this.productLogo,
    required this.pack,
    required this.tradePrice,
    required this.quantity,
    required this.totalPrice,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      productId: json['productId'],
      productName: json['productName'],
      productLogo: json['productLogo'],
      pack: json['pack'],
      tradePrice: json['tradePrice'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
    );
  }
}