class Product {
  final int productId;
  final String productName;
  final double tradePrice;
  final int stock;
  final String pack;  // New field
  final int companyId;
  final String productImage;

  Product({
    required this.productId,
    required this.productName,
    required this.tradePrice,
    required this.stock,
    required this.pack,  // Added to constructor
    required this.companyId,
    required this.productImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      productName: json['productName'],
      tradePrice: json['tradePrice'].toDouble(),
      stock: json['stock'],
      pack: json['pack'],  // Added to fromJson
      companyId: json['companyId'],
      productImage: json['productImage'],
    );
  }

  // Optional: Add toJson() method if you need serialization
  Map<String, dynamic> toJson() => {
    'productId': productId,
    'productName': productName,
    'tradePrice': tradePrice,
    'stock': stock,
    'pack': pack,
    'companyId': companyId,
    'productImage': productImage,
  };
}