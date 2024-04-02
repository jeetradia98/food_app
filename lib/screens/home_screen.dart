import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/blocs/category_bloc/category_bloc.dart';
import 'package:food_app/blocs/item/items_bloc.dart';
import 'package:food_app/model/category_model.dart';
import 'package:food_app/utils/base_colors.dart';
import 'package:food_app/utils/base_extension.dart';
import 'package:food_app/utils/base_strings.dart';
import 'package:food_app/utils/base_styles.dart';
import 'package:food_app/utils/routes.dart';
import 'package:food_app/widgets/custom_buttons.dart';
import 'package:food_app/widgets/image_view.dart';
import 'package:food_app/widgets/item_page_view.dart';

import '../widgets/platform_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(LoadCategories());
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    context.read<CategoryBloc>().close();
    context.read<ItemsBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  /// build category items

                  buildCategoryList,
                  Expanded(
                    child: PageView.builder(
                      itemCount: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return FoodItemPageView(
                          index: index + 1,
                          itemBloc: context.read<ItemsBloc>(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                    right: 10.0,
                    bottom: 10 + MediaQuery.of(context).padding.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HomePageButton(
                      callback: () {
                        Navigator.pushNamed(context, Routes.order);
                      },
                      name: BaseStrings.checkout,
                      backgroundColor: Colors.amber,
                      textColor: BaseColors.black,
                      padding: const EdgeInsets.all(14.0),
                    ),
                    5.0.toVSB,
                    HomePageButton(
                      callback: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.screenSaver, (route) => false);
                      },
                      name: BaseStrings.cancelOrder,
                      backgroundColor: Colors.grey.shade300,
                      textColor: Colors.grey.shade600, //BaseColors.greyLight,
                      padding: const EdgeInsets.all(8.0),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get buildCategoryList {
    return BlocConsumer<CategoryBloc, CategoryState>(
      // bloc: categoryBloc,
      listener: (context, state) {
        if (state is LoadCategoriesCompleted) {
          pageController
              .animateToPage(
                state.pageViewIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              )
              .then((value) => context
                  .read<ItemsBloc>()
                  .add(LoadCategoryItems(state.selectedCategoryId)));
        }
      },
      buildWhen: (previous, current) {
        return current is LoadCategoriesInProgress ||
            current is LoadCategoriesCompleted ||
            current is LoadCategoriesFailed;
      },
      builder: (context, state) {
        if (state is LoadCategoriesInProgress || state is CategoryInitial) {
          return const PlatformIndicator(
            showMessage: false,
          );
        } else if (state is LoadCategoriesCompleted) {
          List<Category> list = state.categoryList;
          return list.isEmpty
              ? BaseStrings.noCategories.noDataError
              : SizedBox(
                  width: 0.26.sw,
                  child: ListView.builder(
                    itemCount: list.length,
                    padding: const EdgeInsets.all(14.0),
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return buildCategory(
                        category: item,
                        isSelected: index == state.pageViewIndex,
                        onTap: () {
                          context
                              .read<CategoryBloc>()
                              .add(SelectedCategory(list, item.id));
                        },
                      );
                    },
                  ),
                );
        } else if (state is LoadCategoriesFailed) {
          return BaseStrings.categoryLoadingFailed.noDataError;
        } else {
          '$state home is state'.toErrorLog;
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget buildCategory({
    required VoidCallback onTap,
    required Category category,
    required bool isSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: BaseColors.transparent,
        highlightColor: BaseColors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ImageView(
                  image: category.imageLink,
                  height: 70.r,
                  width: 70.r,
                  boxFit: BoxFit.cover,
                  imageType: ImageType.network,
                ),
                if (!isSelected)
                  SizedBox(
                    height: 70.r,
                    width: 70.r,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: BaseColors.grey.withOpacity(0.5)),
                    ),
                  ),
              ],
            ),
            12.0.toVSB,
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: BaseStyles.categoryNameText.copyWith(
                color: isSelected ? BaseColors.amber : BaseColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
