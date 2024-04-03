import 'package:equatable/equatable.dart';
import 'package:food_app/database/tableModels/order_table.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends Equatable {
  static const String tableName = OrderTable.tableName;
  static const String categoryIdString = OrderTable.categoryIdString;
  static const String itemIdString = OrderTable.itemIdString;
  static const String categoryNameString = OrderTable.categoryNameString;
  static const String itemNameString = OrderTable.itemNameString;
  static const String itemImageUrlString = OrderTable.itemImageUrlString;
  static const String itemPriceString = OrderTable.itemPriceString;
  static const String qty = OrderTable.qty;
  static const String total = OrderTable.total;

  @JsonKey(name: categoryIdString)
  final int categoryId;

  @JsonKey(name: itemIdString)
  final int itemId;

  @JsonKey(name: categoryNameString)
  final String categoryName;

  @JsonKey(name: itemNameString)
  final String itemName;

  @JsonKey(name: itemImageUrlString)
  final String itemImageUrl;

  @JsonKey(name: itemPriceString)
  final double itemPrice;

  @JsonKey(name: qty)
  final int quantity;

  @JsonKey(name: total)
  final double orderTotal;

  @JsonKey(ignore: true)
  final bool? isDecrement;

  const OrderModel({
    required this.categoryId,
    this.isDecrement,
    required this.itemId,
    required this.categoryName,
    required this.itemName,
    required this.itemImageUrl,
    required this.itemPrice,
    required this.quantity,
    required this.orderTotal,
  });
  @override
  List<Object?> get props => [
        itemId,
        itemName,
        itemPrice,
        quantity,
        orderTotal,
      ];
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderModel copyWith({double? newTotal, int? newQty, bool? isDecrease}) =>
      OrderModel(
        categoryId: categoryId,
        itemId: itemId,
        categoryName: categoryName,
        itemName: itemName,
        itemImageUrl: itemImageUrl,
        itemPrice: itemPrice,
        quantity: newQty ?? quantity,
        orderTotal: newTotal ?? orderTotal,
        isDecrement: isDecrease ?? isDecrement,
      );
}
