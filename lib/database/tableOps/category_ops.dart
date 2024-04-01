import 'dart:developer';

import 'package:food_app/database/db_repo.dart';
import 'package:food_app/model/common_response.dart';
import 'package:food_app/database/tableModels/categoryimages_table.dart';
import 'package:food_app/database/tableModels/categorymasters_table.dart';
import 'package:food_app/utils/base_api_const.dart';

class CategoryOps {
  final String tableName = CategoryMastersTable.tableName;
  final String imageTableName = CategoryImagesTable.tableName;

  //todo: check error to allow insert id don't exist
  Future<CommonResponse> initData() async {
    try {
      await AppDB.instance.getDatabase().execute(
          "INSERT INTO ${CategoryMastersTable.tableName} VALUES(100,'Burger','American in origin');");
      await AppDB.instance.getDatabase().execute(
          "INSERT INTO ${CategoryMastersTable.tableName} VALUES(101,'TEST CAT','SAMPLE desc');");
      await AppDB.instance.getDatabase().execute(
          "INSERT INTO ${CategoryMastersTable.tableName} VALUES(102,'PIZZAS','Italian in origin');");
      await AppDB.instance.getDatabase().execute(
          " INSERT INTO ${CategoryImagesTable.tableName}(${CategoryImagesTable.imageUrl},${CategoryImagesTable.categoryId}) VALUES('https://picsum.photos/id/1024/500',100);");
      await AppDB.instance.getDatabase().execute(
          "INSERT INTO ${CategoryImagesTable.tableName}(${CategoryImagesTable.imageUrl},${CategoryImagesTable.categoryId}) VALUES('https://picsum.photos/id/1000/500',101);");
      await AppDB.instance.getDatabase().execute(
          "INSERT INTO ${CategoryImagesTable.tableName}(${CategoryImagesTable.imageUrl},${CategoryImagesTable.categoryId}) VALUES('https://picsum.photos/id/500/500',102);");

      return CommonResponse(message: 'Success', data: {'val': true});
    } catch (e) {
      log('$e is error');
      return CommonResponse(message: '$e');
    }
  }

  Future<CommonResponse> getAll() async {
    try {
      String query = '''SELECT
      ${CategoryMastersTable.id},${CategoryMastersTable.name},${CategoryImagesTable.imageUrl}
      FROM
      ${CategoryMastersTable.tableName}
      INNER JOIN ${CategoryImagesTable.tableName}
      ON ${CategoryMastersTable.id} = ${CategoryImagesTable.categoryId}''';
      var res = await AppDB.instance.getDatabase().rawQuery(query);

      return CommonResponse(
          message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      log(e.toString());
      return CommonResponse(message: '$e');
    }
  }
}
