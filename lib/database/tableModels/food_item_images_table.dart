import 'package:food_app/database/tableModels/fooditem_table.dart';

class FoodItemImagesTable {
  static const String tableName = "FoodItemImagesTable";

  static const String id = "IImgID";
  static const String imageUrl = "imageUrl";
  static const String itemId = 'itemId';

  static const String createTable = '''CREATE TABLE IF NOT EXISTS $tableName (
      $id INTEGER PRIMARY KEY NOT NULL, 
      $imageUrl TEXT, 
      $itemId INTEGER NOT NULL, 
      FOREIGN KEY ($itemId) REFERENCES ${FoodItemTable.tableName} (${FoodItemTable.id})
      );
      ''';
}
