import 'dart:developer';

import 'package:food_app/database/db_repo.dart';
import 'package:food_app/model/common_response.dart';
import 'package:food_app/model/screensaver_api_model.dart';
import 'package:food_app/database/tableModels/screensavers_table.dart';
import 'package:food_app/utils/base_api_const.dart';

class ScreeSaverOps {
  final String tableName = ScreenSaversTable.tableName;

  Future<CommonResponse> insert(ScreenSaverMastersResponse response) async {
    try {
      await Future.forEach(response.screenSaverMasters!,
          (ScreenSaverMaster element) async {
        return await AppDB.instance
            .getDatabase()
            .insert(tableName, element.toJson());
      });
      return CommonResponse(message: 'Success', data: {'val': true});
    } catch (e) {
      log('$e is error');
      return CommonResponse(message: '$e');
    }
  }

  Future<CommonResponse> getAll() async {
    try {
      var res = await AppDB.instance
          .getDatabase()
          .rawQuery('SELECT * FROM $tableName');

      return CommonResponse(
          message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      log(e.toString());
      return CommonResponse(message: '$e');
    }
  }
}
