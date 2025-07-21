import 'package:anmol_marketing/data/database/database.dart';
import 'package:anmol_marketing/data/models/get_models/get_companies.dart';


class DatabaseHelper {
  final AnmolMarketingDatabase _database = AnmolMarketingDatabase();

  // Company operations
  Future<int> insertCompany(GetCompaniesModel company) async {
    final db = await _database.database;
    return await db!.insert('companies', company.toJson());
  }

  Future<List<GetCompaniesModel>> getCompanies() async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db!.query('companies');
    return List.generate(maps.length, (i) => GetCompaniesModel.fromJson(maps[i]));
  }
  
  Future<int> deleteCompanyById(int id) async {
  final db = await _database.database;
  return await db!.delete(
    'companies',
    where: 'companyId = ?',
    whereArgs: [id],
  );
}

}