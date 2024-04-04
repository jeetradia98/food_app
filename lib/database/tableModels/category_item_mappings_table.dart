import 'package:food_app/database/tableModels/categorymasters_table.dart';
import 'package:food_app/database/tableModels/fooditem_table.dart';

class CategoryItemMappingTable {
  static const String tableName = "categoryItemMappingTable";

  static const String categoryId = 'mapCategoryId';
  static const String itemId = 'mapItemId';

  static const String createTable = '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $categoryId INTEGER NOT NULL,
    $itemId INTEGER NOT NULL,
    PRIMARY KEY ($itemId, $categoryId),
    FOREIGN KEY ($categoryId) REFERENCES ${CategoryMastersTable.tableName} (${CategoryMastersTable.id}),
    FOREIGN KEY ($itemId) REFERENCES ${FoodItemTable.tableName} (${FoodItemTable.id})
  )
''';
}
