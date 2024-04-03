import 'package:food_app/database/db_repo.dart';
import 'package:food_app/database/static_data_json/static_data.dart';
import 'package:food_app/database/tableModels/categoryimages_table.dart';
import 'package:food_app/database/tableModels/categorymasters_table.dart';
import 'package:food_app/model/category_model.dart';
import 'package:food_app/model/common_response.dart';
import 'package:food_app/utils/base_api_const.dart';
import 'package:food_app/utils/base_extension.dart';
import 'package:sqflite/sqflite.dart';

class CategoryOps {
  final String tableName = CategoryMastersTable.tableName;
  final String imageTableName = CategoryImagesTable.tableName;

  Future<CommonResponse> initData() async {
    try {
      ///insert category
      await insertCategories(
        StaticData.categoryData.map((e) => SqlCategory.fromJson(e)),
      );
      await insertCategoryImages(
        StaticData.categoryImageData.map((e) => SqlCategoryImage.fromJson(e)),
      );

      return CommonResponse(message: 'Success', data: {'val': true});
    } catch (e) {
      ('$e is error').toErrorLog;
      return CommonResponse(message: '$e');
    }
  }

  Future<void> insertCategories(
    Iterable<SqlCategory> categories,
  ) async {
    final db = AppDB.instance.getDatabase();

    await Future.forEach(categories, (SqlCategory category) async {
      await db.insert(
        CategoryMastersTable.tableName,
        category.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<void> insertCategoryImages(
    Iterable<SqlCategoryImage> categoryImages,
  ) async {
    final db = AppDB.instance.getDatabase();

    await Future.forEach(categoryImages,
        (SqlCategoryImage categoryImage) async {
      await db.insert(
        CategoryImagesTable.tableName,
        categoryImage.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  // Future<SqlCategory?> getCategoryById(int id) async {
  //   final db = AppDB.instance.getDatabase();
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     CategoryMastersTable.tableName,
  //     where: '${CategoryMastersTable.id} = ?',
  //     whereArgs: [id],
  //   );
  //   if (maps.isEmpty) {
  //     return null; // Return null if category with given ID is not found
  //   }
  //   return SqlCategory(
  //     id: maps.first[CategoryMastersTable.id],
  //     name: maps.first[CategoryMastersTable.name],
  //     description: maps.first[CategoryMastersTable.description],
  //   );
  // }

  Future<CommonResponse> getAll() async {
    try {
      String query =
          '''SELECT ${CategoryMastersTable.id},${CategoryMastersTable.name},${CategoryImagesTable.imageUrl}
      FROM ${CategoryMastersTable.tableName}
      LEFT JOIN ${CategoryImagesTable.tableName}
      ON ${CategoryMastersTable.id} = ${CategoryImagesTable.categoryId}''';

      var res = await AppDB.instance.getDatabase().rawQuery(query);

      return CommonResponse(
          message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      (e.toString()).toErrorLog;
      return CommonResponse(message: '$e');
    }
  }
}
