import 'dart:developer';

import 'package:cash_n_carry/domain/models/product.dart';
import 'package:cash_n_carry/presentation/auth/components/auth_button.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/hero_back_button.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/hero_network_image.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/product_quantity_selector.dart';
import 'package:cash_n_carry/presentation/categories_n_products/product_details/product_details_bloc.dart';
import 'package:cash_n_carry/utils/di/cash_n_carry_di.dart';
import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:cash_n_carry/utils/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Size dimens;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dimens = MediaQuery.of(context).size;
    final product = ModalRoute.of(context)!.settings.arguments! as Product;
    return BlocProvider(
      create: (context) => getIt<ProductDetailsBloc>()
        ..add(GetProductCartStatus(product: product)),
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
          padding: const EdgeInsets.only(top: 5),
          color: AppColors.greyBgDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: HeroNetworkImage(
                        imgWidth: dimens.width,
                        imgHeight: dimens.height * 0.4,
                        product: product,
                        categoryIcon: product.category!.icon,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.greyBgDark),
                          child: Text(
                            "${product.category!.name} - ${product.name}",
                            style: TextStyles.textMediumPinkBold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.greyBgDark),
                          child: Text(
                            "${product.price} \$",
                            style: TextStyles.textMediumGreyBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 15,
                      left: 15,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const HeroBackButton()))
                ],
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description",
                        style: TextStyles.textMediumBlackBold,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Text(
                            product.description,
                            textAlign: TextAlign.start,
                            style: TextStyles.textMediumGreyNormal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
                builder: (context, state) {
                  return Expanded(
                    flex: 1,
                    child: state is AddProductToCartResponse && state.success
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProductQuantitySelector(
                                onQuantitySelected: (selectedQuantity) {
                                  quantity = selectedQuantity;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Delivery Time",
                                      style: TextStyles.textLargeBlackBold,
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/logo.png",
                                            width: 30,
                                            height: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "20-30 min",
                                            style: TextStyles.textMediumBlackBold,
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Builder(builder: (bContext) {
                    return BlocConsumer<ProductDetailsBloc,
                        ProductDetailsState>(
                      listener: (context, state) {
                        if (state is AddProductToCartResponse &&
                            !state.success) {
                          log("error");
                        }
                      },
                      builder: (context, state) {
                        return state is AddingProductToCart
                            ? const CircularProgressIndicator()
                            : AuthButton(
                                title: state is AddProductToCartResponse &&
                                        state.success
                                    ? "Added To Cart"
                                    : "Add To Cart",
                                clickListener: state
                                            is AddProductToCartResponse &&
                                        state.success
                                    ? () {}
                                    : () {
                                        product.quantity = quantity;
                                        bContext.read<ProductDetailsBloc>().add(
                                            AddProductToCart(product: product));
                                      });
                      },
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*Container(
                    width: dimens.width,
                    height: dimens.height * 0.1,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColors.greyBgDark,
                          AppColors.greyBgDark,
                          AppColors.lighterGrey,
                          AppColors.transparent
                        ],
                      ),
                    ),
                  ),*/
