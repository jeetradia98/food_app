import 'package:equatable/equatable.dart';
import 'package:food_app/database/tableModels/fooditem_table.dart';
import 'package:food_app/database/tableModels/food_item_images_table.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_item_model.g.dart';

@JsonSerializable()
class FoodItem extends Equatable {
  @JsonKey(name: FoodItemTable.id)
  final int id;
  @JsonKey(name: FoodItemImagesTable.imageUrl)
  final String imageLinks;
  @JsonKey(name: FoodItemTable.name)
  final String name;
  @JsonKey(name: FoodItemTable.price)
  final double price;

  String? get imageLink => imageLinks.split(',').first;

  const FoodItem({
    required this.id,
    required this.imageLinks,
    required this.name,
    required this.price,
  });

  @override
  String toString() {
    return '$name $id $imageLinks $price';
  }

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);

  Map<String, dynamic> toJson() => _$FoodItemToJson(this);

  @override
  List<Object?> get props => [id, imageLinks, name, price];
}

@JsonSerializable()
class SqlFoodItem extends Equatable {
  @JsonKey(name: FoodItemTable.id)
  final int id;
  @JsonKey(name: FoodItemTable.name)
  final String name;
  @JsonKey(name: FoodItemTable.price)
  final double price;

  const SqlFoodItem({
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  String toString() {
    return '$name $id $price';
  }

  factory SqlFoodItem.fromJson(Map<String, dynamic> json) =>
      _$SqlFoodItemFromJson(json);

  Map<String, dynamic> toJson() => _$SqlFoodItemToJson(this);

  @override
  List<Object?> get props => [id, name, price];
}

@JsonSerializable()
class SqlFoodItemImage extends Equatable {
  @JsonKey(name: FoodItemImagesTable.id)
  final int? id;
  @JsonKey(name: FoodItemImagesTable.itemId)
  final int foodItemId;
  @JsonKey(name: FoodItemImagesTable.imageUrl)
  final String imageUrl;

  const SqlFoodItemImage({
    this.id,
    required this.foodItemId,
    required this.imageUrl,
  });

  factory SqlFoodItemImage.fromJson(Map<String, dynamic> json) =>
      _$SqlFoodItemImageFromJson(json);

  Map<String, dynamic> toJson() => _$SqlFoodItemImageToJson(this);

  @override
  List<Object?> get props => [id, foodItemId, imageUrl];
}
