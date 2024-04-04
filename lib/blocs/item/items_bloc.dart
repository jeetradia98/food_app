import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/database/tableOps/category_item_mapping_ops.dart';
import 'package:food_app/database/tableOps/fooditem_ops.dart';
import 'package:food_app/database/tableOps/order_model_ops.dart';
import 'package:food_app/model/common_response.dart';
import 'package:food_app/model/food_item_model.dart';
import 'package:food_app/utils/base_api_const.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final CategoryItemMapOps categoryItemMapOps = CategoryItemMapOps();
  final FoodItemOps foodItemOps = FoodItemOps();
  final OrderModelOps orderModelOps = OrderModelOps();

  ItemsBloc() : super(ItemsInitial()) {
    on<ItemsEvent>((event, emit) async {
      if (event is LoadCategoryItems) {
        await onLoadCategoryItems(event, emit);
      }
    });
  }

  Future<void> onLoadCategoryItems(
    LoadCategoryItems event,
    Emitter emit,
  ) async {
    emit.call(LoadCategoryItemsInProgress());

    final CommonResponse response =
        await foodItemOps.getAllCategoryFoodItems(event.categoryId);
    ////

    if (response.data != null) {
      final itemList = (response.data![BaseApiConstants.val] as List)
          .map((e) => FoodItem.fromJson(e))
          .toList();
      // '$itemList is item list'.toLog;
      emit.call(LoadCategoryItemsCompleted(itemList));
    } else {
      emit.call(LoadCategoryItemsFailed(response.message));
    }
  }
}
