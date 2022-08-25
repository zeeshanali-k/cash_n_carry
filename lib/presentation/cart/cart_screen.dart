import 'dart:developer';

import 'package:cash_n_carry/presentation/cart/components/cart_item.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/hero_back_button.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/hero_title.dart';
import 'package:cash_n_carry/presentation/home/components/hero_cart_icon.dart';
import 'package:cash_n_carry/utils/di/cash_n_carry_di.dart';
import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:cash_n_carry/utils/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cart_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final imgWidthHeight = 90;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => getIt<CartBloc>()..add(GetCartProducts()),
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
                      child: const HeroBackButton(),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: HeroCartIcon(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: HeroTitle(
                        tag: "title_tv",
                        title: "Cart",
                        textStyle: TextStyles.textLargePinkBold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocConsumer<CartBloc, CartState>(
                  listener: (context, state) {
                    if (state is GetCartProductsRes) {
                      log(state.cartProducts!.length.toString());
                    }
                  },
                  builder: (context, state) {
                    return state is GetCartProductsRes
                        ? state.cartProducts?.isEmpty ?? false
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    CupertinoIcons.cart,
                                    size: 50.0,
                                    color: AppColors.pinkColor,
                                  ),
                                  Text(
                                    "Add Items to Cart",
                                    style: TextStyles.textLargeBlackBold,
                                  ),
                                ],
                              )
                            : Builder(builder: (bContext) {
                                return ListView.builder(
                                  itemBuilder: (ctx, pos) => Dismissible(
                                    direction: DismissDirection.endToStart,
                                    key: Key(state.cartProducts![pos].id!),
                                    onDismissed: (_) {
                                      bContext.read<CartBloc>().add(
                                            ProductDeleted(pos: pos),
                                          );
                                    },
                                    background: Padding(
                                      padding: EdgeInsets.only(
                                          top: imgWidthHeight * 0.7,
                                          bottom: imgWidthHeight * 0.2),
                                      child: Container(
                                        color: AppColors.red,
                                        width: size.width,
                                        height: 30,
                                        child: SizedBox.expand(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: CartItem(
                                      product: state.cartProducts![pos],
                                      onDeleteClicked: () {
                                        bContext.read<CartBloc>().add(
                                              ProductDeleted(
                                                pos: pos,
                                              ),
                                            );
                                      },
                                      categoryIcon: "assets/images/logo.png",
                                      onQuantitySelected: (newQuantity) {
                                        bContext.read<CartBloc>().add(
                                              QuantityChanged(
                                                  quantity: newQuantity,
                                                  pos: pos),
                                            );
                                      },
                                    ),
                                  ),
                                  itemCount: state.cartProducts!.length,
                                );
                              })
                        : SizedBox(
                            width: size.width * 0.1,
                            height: size.height * 0.1,
                            child: const FittedBox(child: CircularProgressIndicator()),
                          );
                  },
                ),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return state is GetCartProductsRes &&
                          state.cartProducts!.isNotEmpty
                      ? Builder(builder: (bContext) {
                          return InkResponse(
                            onTap: () {
                              bContext.read<CartBloc>().add(PlaceOrder());
                              Fluttertoast.showToast(msg: "Ordered");
                            },
                            child: Container(
                              width: size.width,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              color: AppColors.backgroundColor,
                              child: const Text(
                                "Place Order",
                                style: TextStyles.textLargeWhiteBold,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        })
                      : const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
