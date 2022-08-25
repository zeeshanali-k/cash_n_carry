import 'package:cash_n_carry/domain/models/category.dart';
import 'package:cash_n_carry/presentation/categories_n_products/category_products/category_products_bloc.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/category_hero_image.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/hero_back_button.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/hero_title.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/product_item.dart';
import 'package:cash_n_carry/utils/constants/screens.dart';
import 'package:cash_n_carry/utils/di/cash_n_carry_di.dart';
import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({Key? key}) : super(key: key);

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;
    return BlocProvider(
      create: (context) => getIt<CategoryProductsBloc>()
        ..add(GetCategoryProducts(categoryId: category.id)),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.greyBgDark,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
          toolbarHeight: 0,
          elevation: 0,
        ),
        body: Container(
          color: AppColors.greyBgDark,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const HeroBackButton()),
                    const SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CategoryHeroImage(
                          imgWidthHeight: 35, categoryIcon: category.icon),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: HeroTitle(
                        title: category.name,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocConsumer<CategoryProductsBloc, CategoryProductsState>(
                      listener: (context, state) {
                        if (state is GetCategoryProductsRes &&
                            !state.isSuccess) {
                          Fluttertoast.showToast(
                              msg: "Error Loading",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              gravity: ToastGravity.BOTTOM);
                        }
                      },
                      builder: (context, state) {
                        return state is GetCategoryProductsRes
                            ? Expanded(
                                child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemBuilder: (_, index) => ProductItem(
                                      categoryIcon: category.icon,
                                      product: state.products![index],
                                      onItemClicked: (clickedProduct) {
                                        clickedProduct.category = category;
                                        Navigator.of(context).pushNamed(
                                          ScreenProductDetail().route,
                                          arguments: clickedProduct,
                                        );
                                      }),
                                  itemCount: state.products?.length ?? 0,
                                ),
                              )
                            : const CircularProgressIndicator();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
