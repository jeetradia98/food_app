class FoodItemTable {
  static const String tableName = "FoodItem";

  static const String id = "id";
  static const String name = "itemName";
  static const String description = "fullDescription";
  static const String price = 'price';

  static const String createTable =
      "CREATE TABLE IF NOT EXISTS $tableName ($id INTEGER PRIMARY KEY NOT NULL, $name TEXT, $description	TEXT, $price	REAL)";
}
