import 'package:food_app/database/tableModels/categoryimages_table.dart';
import 'package:food_app/database/tableModels/categorymasters_table.dart';
import 'package:food_app/database/tableModels/fooditem_table.dart';
import 'package:food_app/database/tableModels/food_item_images_table.dart';

class CategoryItemMappingTable {
  static const String tableName = "categoryItemMappingTable";

  static const String categoryId = CategoryMastersTable.id;
  static const String categoryImageUrl = CategoryImagesTable.imageUrl;
  static const String categoryName = CategoryMastersTable.name;
  static const String categoryDesc = CategoryMastersTable.description;
  static const String itemId = FoodItemTable.id;
  static const String itemName = FoodItemTable.name;
  static const String itemDesc = FoodItemTable.description;
  static const String itemPrice = FoodItemTable.price;
  static const String itemImageUrl = FoodItemImagesTable.imageUrl;

  static const String createTable =
      '''CREATE TABLE IF NOT EXISTS $tableName ($categoryId INTEGER NOT NULL,$itemId INTEGER NOT NULL, $categoryImageUrl TEXT, $itemImageUrl TEXT, $categoryName TEXT, $categoryDesc TEXT,$itemName TEXT,$itemDesc TEXT, $itemPrice REAL,PRIMARY KEY ($itemId, $categoryId),FOREIGN KEY ($categoryId) REFERENCES ${CategoryMastersTable.tableName} (${CategoryMastersTable.id}), FOREIGN KEY ($itemId) REFERENCES ${FoodItemTable.tableName} (${FoodItemTable.id}))''';
}
