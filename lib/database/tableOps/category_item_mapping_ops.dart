import 'dart:developer';

import 'package:food_app/database/db_repo.dart';
import 'package:food_app/database/static_data_json/static_data.dart';
import 'package:food_app/database/tableModels/category_item_mappings_table.dart';
import 'package:food_app/model/common_response.dart';
import 'package:food_app/utils/base_api_const.dart';
import 'package:sqflite/sqflite.dart';

class CategoryItemMapOps {
  final String tableName = CategoryItemMappingTable.tableName;

  Future<CommonResponse> initData() async {
    try {
      // await Future.wait([
      //   AppDB.instance.getDatabase().execute('''
      // INSERT INTO $tableName VALUES (100,200,'https://picsum.photos/id/1024/500','https://picsum.photos/id/24/500','BURGER','AMERICAN in nature','McAloo Tikki', 'type of burger', 150);
      // '''),
      //   AppDB.instance.getDatabase().execute('''
      // INSERT INTO $tableName VALUES (102,201,'https://picsum.photos/id/1025/500','https://picsum.photos/id/25/500','Pizza','AMERICAN in nature','Itallina', 'type of pizza', 1250);
      // '''),
      //   AppDB.instance.getDatabase().execute('''
      // INSERT INTO $tableName VALUES (102,202,'https://picsum.photos/id/1025/500','https://picsum.photos/id/28/500','Pizza','AMERICAN in nature','McAloo Pizza 2', 'type of pizza', 550);
      // '''),
      //   AppDB.instance.getDatabase().execute('''
      //   INSERT INTO $tableName VALUES (100,203,'https://picsum.photos/id/1024/500','https://picsum.photos/id/26/500','BURGER','AMERICAN in nature','McAloo MEXICAN Tikki', 'type of burger', 350);
      // ''')
      // ]);

      // Map each food item to its corresponding category
      for (var foodItem in StaticData.foodItemsData) {
        // Get the category ID for the current food item
        int? categoryId;
        var itemName = (foodItem['itemName'] as String).toLowerCase();
        var burger = 'Burger'.toLowerCase();
        var pizza = 'Pizza'.toLowerCase();
        if (itemName.contains(burger)) {
          categoryId = 100; // Burger category ID
        } else if (itemName.contains(pizza)) {
          categoryId = 102; // Pizza category ID
        } else {
          categoryId = 101; // Default category ID (or handle other categories)
        }

        insertCategoryItemMap(categoryId: categoryId, itemId: foodItem['id']);
      }

      return CommonResponse(message: 'Success', data: {'val': true});
    } catch (e) {
      log('$e is error');
      return CommonResponse(message: '$e');
    }
  }

  Future<void> insertCategoryItemMap(
      {required int categoryId, required int itemId}) async {
    final db = AppDB.instance.getDatabase();

    await db.insert(
      tableName,
      {
        CategoryItemMappingTable.categoryId: categoryId,
        CategoryItemMappingTable.itemId: itemId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<CommonResponse> getAllCategoryFoodMap(int cId) async {
    try {
      var res = await AppDB.instance.getDatabase().rawQuery('''
          SELECT * FROM ${CategoryItemMappingTable.tableName}
          ''');

      return CommonResponse(
          message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      log(e.toString());
      return CommonResponse(message: '$e');
    }
  }
}
