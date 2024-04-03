import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:food_app/database/tableModels/categoryimages_table.dart';
import 'package:food_app/database/tableModels/categorymasters_table.dart';

part 'category_model.g.dart';

@JsonSerializable()
class Category extends Equatable {
  @JsonKey(name: CategoryMastersTable.id)
  final int id;
  @JsonKey(name: CategoryImagesTable.imageUrl)
  final String imageLink;
  @JsonKey(name: CategoryMastersTable.name)
  final String name;
  @JsonKey(name: CategoryMastersTable.description)
  final String? description;

  const Category({
    required this.id,
    required this.name,
    required this.imageLink,
    this.description,
  });

  @override
  String toString() {
    return '$name $id $imageLink';
  }

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props => [id, name, imageLink];
}

@JsonSerializable()
class SqlCategory extends Equatable {
  @JsonKey(name: CategoryMastersTable.id)
  final int id;
  @JsonKey(name: CategoryMastersTable.name)
  final String name;
  @JsonKey(name: CategoryMastersTable.description)
  final String description;

  const SqlCategory({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  String toString() {
    return '$name $id $description';
  }

  factory SqlCategory.fromJson(Map<String, dynamic> json) =>
      _$SqlCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SqlCategoryToJson(this);

  @override
  List<Object?> get props => [id];
}

@JsonSerializable()
class SqlCategoryImage extends Equatable {
  @JsonKey(name: CategoryImagesTable.id)
  final int? id;
  @JsonKey(name: CategoryImagesTable.categoryId)
  final int categoryId;
  @JsonKey(name: CategoryImagesTable.imageUrl)
  final String imageUrl;

  const SqlCategoryImage({
    this.id,
    required this.categoryId,
    required this.imageUrl,
  });

  factory SqlCategoryImage.fromJson(Map<String, dynamic> json) =>
      _$SqlCategoryImageFromJson(json);

  Map<String, dynamic> toJson() => _$SqlCategoryImageToJson(this);

  @override
  List<Object?> get props => [id, categoryId, imageUrl];
}
