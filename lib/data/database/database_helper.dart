import 'package:anmol_marketing/data/database/database.dart';
import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/models/get_models/get_products.dart';
import 'package:anmol_marketing/data/models/post_models/create_order_for_local.dart';

class DatabaseHelper {
  final AnmolMarketingDatabase _database = AnmolMarketingDatabase();

  /// Inserts a company into the 'companies' table
  /// @param company: The company model to insert
  /// @return: The row ID of the inserted company, or -1 if failed
  Future<int> insertCompany(GetCompaniesModel company) async {
    try {
      final db = await _database.database;
      return await db!.insert('companies', company.toJson());
    } catch (e) {
      print('Error inserting company: $e');
      return -1;
    }
  }

  /// Inserts a company into the 'catalog' table
  /// @param company: The company model to insert
  /// @return: The row ID of the inserted company, or -1 if failed
  Future<int> insertCompaniesToCatalog(GetCompaniesModel company) async {
    try {
      final db = await _database.database;
      return await db!.insert('catalog', company.toJson());
    } catch (e) {
      print('Error inserting company to catalog: $e');
      return -1;
    }
  }

  /// Retrieves all companies from the 'companies' table
  /// @return: List of GetCompaniesModel, or empty list if failed
  Future<List<GetCompaniesModel>> getCompanies() async {
    try {
      final db = await _database.database;
      final List<Map<String, dynamic>> maps = await db!.query('companies');
      return List.generate(
        maps.length,
        (i) => GetCompaniesModel.fromJson(maps[i]),
      );
    } catch (e) {
      print('Error fetching companies: $e');
      return [];
    }
  }

  /// Retrieves all companies from the 'catalog' table
  /// @return: List of GetCompaniesModel, or empty list if failed
  Future<List<GetCompaniesModel>> getCatalogCompanies() async {
    try {
      final db = await _database.database;
      final List<Map<String, dynamic>> maps = await db!.query('catalog');
      return List.generate(
        maps.length,
        (i) => GetCompaniesModel.fromJson(maps[i]),
      );
    } catch (e) {
      print('Error fetching catalog companies: $e');
      return [];
    }
  }

  /// Deletes a company by its ID from the 'companies' table
  /// @param id: The companyId to delete
  /// @return: Number of rows affected, or -1 if failed
  Future<int> deleteCompanyById(int id) async {
    try {
      final db = await _database.database;
      return await db!.delete(
        'companies',
        where: 'companyId = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting company by ID: $e');
      return -1;
    }
  }

  /// Clears all data from the 'companies' table
  Future<void> clearCompaniesTable() async {
    try {
      final db = await _database.database;
      await db!.delete('companies');
    } catch (e) {
      print('Error clearing companies table: $e');
    }
  }

  /// Creates a new order in the 'orders' table
  /// @param grandTotal: The total amount for the order
  /// @param totalProducts: Total number of products in the order
  /// @return: The generated orderId, or empty string if failed
  Future<String> createOrder({
    required double grandTotal,
    required int totalProducts,
  }) async {
    try {
      final db = await _database.database;
      final orderId = DateTime.now().millisecondsSinceEpoch.toString();

      await db!.insert('orders', {
        'orderId': orderId,
        'orderDate': DateTime.now().toIso8601String(),
        'grandTotal': grandTotal,
        'totalProducts': totalProducts,
      });

      return orderId;
    } catch (e) {
      print('Error creating order: $e');
      return '';
    }
  }

  /// Adds a company to an order in the 'order_companies' table
  /// @param orderId: The order this company belongs to
  /// @param company: The company model to add
  /// @param companyTotal: Total amount for this company in the order
  /// @param totalProducts: Number of products for this company in the order
  /// @return: The row ID of the inserted record, or -1 if failed
  Future<int> addOrderCompany({
    required String orderId,
    required GetCompaniesModel company,
    required double companyTotal,
    required int totalProducts,
  }) async {
    try {
      final db = await _database.database;
      return await db!.insert('order_companies', {
        'orderId': orderId,
        'companyId': company.companyId,
        'companyName': company.companyName,
        'companyLogo': company.companyLogo,
        'companyTotal': companyTotal,
        'totalProducts': totalProducts,
      });
    } catch (e) {
      print('Error adding order company: $e');
      return -1;
    }
  }

  /// Adds a product to an order in the 'order_products' table
  /// @param orderId: The order this product belongs to
  /// @param companyId: The company this product belongs to
  /// @param product: The product model to add
  /// @param quantity: The quantity of this product in the order
  /// @param totalPrice: The total price (quantity * tradePrice)
  /// @return: The row ID of the inserted record, or -1 if failed
  Future<int> addOrderProduct({
    required String orderId,
    required int companyId,
    required GetProductsModel product,
    required int quantity,
    required double totalPrice,
  }) async {
    try {
      final db = await _database.database;
      return await db!.insert('order_products', {
        'orderId': orderId,
        'companyId': companyId,
        'productId': product.productId,
        'productName': product.productName,
        'productLogo': product.productLogo,
        'pack': product.pack,
        'tradePrice': product.tradePrice,
        'quantity': quantity,
        'totalPrice': totalPrice,
        'productStock': product.productStock,
        'salePrice': product.salePrice,
      });
    } catch (e) {
      print('Error adding order product: $e');
      return -1;
    }
  }

  /// Retrieves all companies associated with a specific order
  /// @param orderId: The order to get companies for
  /// @return: List of company records, or empty list if failed
  Future<List<Map<String, dynamic>>> getOrderCompanies(String orderId) async {
    try {
      final db = await _database.database;
      return await db!.query(
        'order_companies',
        where: 'orderId = ?',
        whereArgs: [orderId],
      );
    } catch (e) {
      print('Error fetching order companies: $e');
      return [];
    }
  }

  /// Retrieves all products for a specific company in an order
  /// @param orderId: The order to get products for
  /// @param companyId: The company to get products for
  /// @return: List of product records, or empty list if failed
  Future<List<Map<String, dynamic>>> getOrderProducts({
    required String orderId,
    required int companyId,
  }) async {
    try {
      final db = await _database.database;
      return await db!.query(
        'order_products',
        where: 'orderId = ? AND companyId = ?',
        whereArgs: [orderId, companyId],
      );
    } catch (e) {
      print('Error fetching order products: $e');
      return [];
    }
  }

  /// Deletes an order and all its related data (companies and products)
  /// @param orderId: The order to delete
  /// @return: Number of rows affected in orders table, or -1 if failed
  Future<int> deleteOrder(String orderId) async {
    try {
      final db = await _database.database;
      await db!.delete(
        'order_products',
        where: 'orderId = ?',
        whereArgs: [orderId],
      );
      await db.delete(
        'order_companies',
        where: 'orderId = ?',
        whereArgs: [orderId],
      );
      return await db.delete(
        'orders',
        where: 'orderId = ?',
        whereArgs: [orderId],
      );
    } catch (e) {
      print('Error deleting order: $e');
      return -1;
    }
  }

  /// Retrieves all orders with their complete hierarchy (companies and products)
  /// @return: List of OrderModel with nested data, or empty list if failed
  Future<List<OrderModel>> getAllOrders() async {
    try {
      final db = await _database.database;

      // Get all orders
      final List<Map<String, dynamic>> orders = await db!.query(
        'orders',
        orderBy: 'orderDate DESC',
      );

      List<OrderModel> orderList = [];

      for (var order in orders) {
        // Get companies for this order
        final List<Map<String, dynamic>> companies = await db.query(
          'order_companies',
          where: 'orderId = ?',
          whereArgs: [order['orderId']],
        );

        List<OrderCompany> companyList = [];

        for (var company in companies) {
          // Get products for this company in this order
          final List<Map<String, dynamic>> products = await db.query(
            'order_products',
            where: 'orderId = ? AND companyId = ?',
            whereArgs: [order['orderId'], company['companyId']],
          );

          companyList.add(
            OrderCompany(
              companyId: company['companyId'],
              companyName: company['companyName'],
              companyLogo: company['companyLogo'],
              companyTotal: company['companyTotal'],
              totalProducts: company['totalProducts'],
              products: products.map((p) => OrderProduct.fromJson(p)).toList(),
            ),
          );
        }

        orderList.add(
          OrderModel(
            orderId: order['orderId'],
            orderDate: order['orderDate'],
            grandTotal: order['grandTotal'],
            totalProducts: order['totalProducts'],
            companies: companyList,
          ),
        );
      }

      return orderList;
    } catch (e) {
      print('Error fetching all orders: $e');
      return [];
    }
  }

  /// Checks if a company already exists in an order
  Future<bool> doesCompanyExistInOrder(String orderId, int companyId) async {
    try {
      final db = await _database.database;
      final result = await db!.query(
        'order_companies',
        where: 'orderId = ? AND companyId = ?',
        whereArgs: [orderId, companyId],
        limit: 1,
      );
      return result.isNotEmpty;
    } catch (e) {
      print('Error checking company existence: $e');
      return false;
    }
  }

  /// Updates an existing company in an order
  Future<int> updateOrderCompany({
    required String orderId,
    required GetCompaniesModel company,
    required double companyTotal,
    required int totalProducts,
  }) async {
    try {
      final db = await _database.database;
      return await db!.update(
        'order_companies',
        {'companyTotal': companyTotal, 'totalProducts': totalProducts},
        where: 'orderId = ? AND companyId = ?',
        whereArgs: [orderId, company.companyId],
      );
    } catch (e) {
      print('Error updating order company: $e');
      return -1;
    }
  }

  /// Deletes all products for a company in an order
  Future<int> deleteOrderProducts(String orderId, int companyId) async {
    try {
      final db = await _database.database;
      return await db!.delete(
        'order_products',
        where: 'orderId = ? AND companyId = ?',
        whereArgs: [orderId, companyId],
      );
    } catch (e) {
      print('Error deleting order products: $e');
      return -1;
    }
  }

  /// Updates the totals for an existing order
  Future<int> updateOrderTotals({
    required String orderId,
    required double grandTotal,
    required int totalProducts,
  }) async {
    try {
      final db = await _database.database;
      return await db!.update(
        'orders',
        {'grandTotal': grandTotal, 'totalProducts': totalProducts},
        where: 'orderId = ?',
        whereArgs: [orderId],
      );
    } catch (e) {
      print('Error updating order totals: $e');
      return -1;
    }
  }

  /// Deletes all orders and their related data (companies and products)
  /// @return: Future<bool> indicating success (true) or failure (false)
  Future<bool> clearAllOrders() async {
    try {
      final db = await _database.database;

      // Start a transaction to ensure all deletions happen atomically
      await db!.transaction((txn) async {
        // Delete all order products
        await txn.delete('order_products');

        // Delete all order companies
        await txn.delete('order_companies');

        // Delete all orders
        await txn.delete('orders');
      });

      return true;
    } catch (e) {
      print('Error clearing all orders: $e');
      return false;
    }
  }
}
