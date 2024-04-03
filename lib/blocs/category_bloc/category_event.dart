part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class LoadCategoriesEvent extends CategoryEvent {
  @override
  List<Object?> get props => ['LoadCategories'];
}

class SelectedCategoryEvent extends CategoryEvent {
  const SelectedCategoryEvent(this.categoryList, this.id);
  final List<Category> categoryList;
  final int id;

  @override
  List<Object?> get props => [categoryList, id];
}

class LoadItemsByCategoryEvent extends CategoryEvent {
  const LoadItemsByCategoryEvent(this.categoryId);
  final int categoryId;

  @override
  List<Object?> get props => [categoryId];
}
