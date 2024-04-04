import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show TabController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/database/tableOps/category_ops.dart';
import 'package:food_app/model/category_model.dart';
import 'package:food_app/model/common_response.dart';
import 'package:food_app/model/food_item_model.dart';
import 'package:food_app/utils/base_api_const.dart';
import 'package:food_app/utils/base_extension.dart';
import 'package:food_app/utils/base_strings.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryOps categoryOps = CategoryOps();
  late TabController tabController;

  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is LoadCategoriesEvent) {
        await onLoadCategories(event, emit);
      }
      if (event is SelectedCategoryEvent) {
        int index =
            event.categoryList.indexWhere((element) => event.id == element.id);
        index = index != -1 ? index : 1;
        emit.call(LoadCategoriesCompleted(
            categoryList: event.categoryList,
            pageViewIndex: index,
            selectedCategoryId: event.id));
      }
    });
  }

  Future<void> onLoadCategories(CategoryEvent event, Emitter emit) async {
    try {
      emit.call(LoadCategoriesInProgress());

      final CommonResponse res = await categoryOps.getAll();

      if (res.data == null) {
        emit.call(LoadCategoriesFailed(res.message));
        return;
      }

      var data = res.data![BaseApiConstants.val] as List;
      if (data.isEmpty) {
        emit.call(const LoadCategoriesFailed(BaseStrings.noCategories));
        return;
      }

      final cList = data.map((e) => Category.fromJson(e)).toList();
      '$cList is cate list'.toLog;
      //todo resolve case when no category
      emit.call(
        LoadCategoriesCompleted(
          categoryList: cList,
          pageViewIndex: 0,
          selectedCategoryId: cList.first.id,
        ),
      );
    } catch (e) {
      '$e'.toErrorLog;
      emit.call(const LoadCategoriesFailed(BaseStrings.categoryLoadingFailed));
    }
  }
}
