import 'package:food_app/database/db_repo.dart';
import 'package:food_app/database/static_data_json/static_data.dart';
import 'package:food_app/database/tableModels/fooditem_table.dart';
import 'package:food_app/database/tableModels/food_item_images_table.dart';
import 'package:food_app/model/common_response.dart';
import 'package:food_app/model/food_item_model.dart';
import 'package:food_app/utils/base_api_const.dart';
import 'package:food_app/utils/base_extension.dart';
import 'package:sqflite/sqflite.dart';

class FoodItemOps {
  final String tableName = FoodItemTable.tableName;
  final String imageTableName = FoodItemImagesTable.tableName;
  Future<CommonResponse> initData() async {
    try {
      //note: without await keyword error is not catch here
      ///insert category
      await insertFoodItem(
        StaticData.foodItemsData.map((e) => SqlFoodItem.fromJson(e)),
      );
      await insertFoodItemImages(
        StaticData.foodItemImagesData.map((e) => SqlFoodItemImage.fromJson(e)),
      );

      return CommonResponse(message: 'Success', data: {'val': true});
    } catch (e, s) {
      ('$e \n\n$s is error 123').toErrorLog;
      return CommonResponse(message: '$e');
    }
  }

  Future<void> insertFoodItem(
    Iterable<SqlFoodItem> items,
  ) async {
    final db = AppDB.instance.getDatabase();
    for (SqlFoodItem item in items) {
      await db.insert(
        FoodItemTable.tableName,
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> insertFoodItemImages(
    Iterable<SqlFoodItemImage> categoryImages,
  ) async {
    final db = AppDB.instance.getDatabase();

    await Future.forEach(categoryImages, (SqlFoodItemImage image) async {
      await db.insert(
        FoodItemImagesTable.tableName,
        image.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<CommonResponse> getAll() async {
    try {
      String query =
          '''SELECT ${FoodItemTable.id},${FoodItemTable.name},${FoodItemImagesTable.imageUrl},${FoodItemTable.price}
      FROM ${FoodItemTable.tableName}
      LEFT JOIN ${FoodItemImagesTable.tableName}
      ON ${FoodItemTable.id} = ${FoodItemImagesTable.itemId}''';

      var res = await AppDB.instance.getDatabase().rawQuery(query);

      return CommonResponse(
          message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      (e.toString()).toErrorLog;
      return CommonResponse(message: '$e');
    }
  }
}
