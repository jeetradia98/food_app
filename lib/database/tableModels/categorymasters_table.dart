class CategoryMastersTable {
  static const String tableName = "CategoryMasters";

  static const String id = "cId";
  static const String name = "categoryName";
  static const String description = "description";

  static const String createTable =
      "CREATE TABLE IF NOT EXISTS $tableName ($id INTEGER PRIMARY KEY, $name TEXT, $description	TEXT)";
}
