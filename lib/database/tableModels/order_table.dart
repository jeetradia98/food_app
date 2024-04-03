import 'categorymasters_table.dart';
import 'food_item_images_table.dart';
import 'fooditem_table.dart';

class OrderTable {
  static const String tableName = "OrderTable";
  static const String categoryIdString = CategoryMastersTable.id;
  static const String itemIdString = FoodItemTable.id;
  static const String categoryNameString = CategoryMastersTable.name;
  static const String itemNameString = FoodItemTable.name;
  static const String itemImageUrlString = FoodItemImagesTable.imageUrl;
  static const String itemPriceString = FoodItemTable.price;
  static const String qty = 'qty';
  static const String total = 'total';

  static const String createTable = '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $categoryNameString TEXT,
    $itemNameString TEXT,
    $itemImageUrlString TEXT,
    $total REAL,
    $qty INTEGER,
    $itemPriceString REAL,
    $itemIdString INTEGER PRIMARY KEY NOT NULL,
    $categoryIdString INTEGER NOT NULL,
    FOREIGN KEY ($itemIdString) REFERENCES ${FoodItemTable.tableName} (${FoodItemTable.id}),
    FOREIGN KEY ($categoryIdString) REFERENCES ${CategoryMastersTable.tableName} (${CategoryMastersTable.id})
  )
''';
}
