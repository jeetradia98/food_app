import 'package:food_app/database/tableModels/category_item_mappings_table.dart';
import 'package:food_app/database/tableModels/categoryimages_table.dart';
import 'package:food_app/database/tableModels/categorymasters_table.dart';
import 'package:food_app/database/tableModels/order_table.dart';
import 'package:food_app/database/tableModels/screensavers_table.dart';
import 'package:food_app/utils/base_extension.dart';
import 'package:sqflite/sqflite.dart';

import 'tableModels/food_item_images_table.dart';
import 'tableModels/fooditem_table.dart';

class AppDatabaseInfo {
  static const String databaseName = "food_app.db";
  static const int databaseVersion = 1;

  // static List<String> getTableNameList() {
  //   List<String> dbTableNameList = [];
  //   dbTableNameList.add(ScreenSaversTable.tableName);
  //   dbTableNameList.add(CategoryMastersTable.tableName);
  //   dbTableNameList.add(FoodItemTable.tableName);
  //   dbTableNameList.add(CategoryImagesTable.tableName);
  //   dbTableNameList.add(FoodItemImagesTable.tableName);
  //   dbTableNameList.add(CategoryItemMappingTable.tableName);
  //   dbTableNameList.add(OrderTable.tableName);
  //   return dbTableNameList;
  // }
  //
  // static List<String> generateDropQueryList() {
  //   List<String> dbDropList = getTableNameList();
  //   for (var i = 0; i < getTableNameList().length; i++) {
  //     String query = "DROP TABLE IF EXISTS ${getTableNameList()[i]}";
  //     dbDropList.add(query);
  //   }
  //   return dbDropList;
  // }

  List<String> _generateCreationQueryList() {
    List<String> dbQueryList = [];
    dbQueryList.add(ScreenSaversTable.createTable);
    dbQueryList.add(CategoryMastersTable.createTable);
    dbQueryList.add(FoodItemTable.createTable);
    dbQueryList.add(CategoryImagesTable.createTable);
    dbQueryList.add(FoodItemImagesTable.createTable);
    dbQueryList.add(CategoryItemMappingTable.createTable);
    dbQueryList.add(OrderTable.createTable);
    return dbQueryList;
  }

  Future<bool> initDb(Database theDb) async {
    // List<String> dbDropList = _generateDropQueryList();
    List<String> dbSchemaQueryList = _generateCreationQueryList();

    for (var i = 0; i < dbSchemaQueryList.length; i++) {
      // '${dbSchemaQueryList[i]} to be created'.toLog;
      theDb.execute(dbSchemaQueryList[i]);
    }
    'new tables created'.toLog;

    return true;
  }
}
