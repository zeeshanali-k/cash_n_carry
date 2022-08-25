import 'package:cash_n_carry/presentation/auth/login/login_screen.dart';
import 'package:cash_n_carry/presentation/auth/register/register_screen.dart';
import 'package:cash_n_carry/presentation/cart/cart_screen.dart';
import 'package:cash_n_carry/presentation/categories_n_products/category_products/category_products_screen.dart';
import 'package:cash_n_carry/presentation/categories_n_products/product_details/product_detail_screen.dart';
import 'package:cash_n_carry/presentation/home/home_screen.dart';
import 'package:cash_n_carry/presentation/splash_screen.dart';
import 'package:cash_n_carry/utils/animations/animation_page_route.dart';
import 'package:cash_n_carry/utils/animations/hero_animation_page_route.dart';
import 'package:cash_n_carry/utils/constants/screens.dart';
import 'package:cash_n_carry/utils/di/cash_n_carry_di.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initCashnCarry();
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
      fontFamily: "nunito"
    ),
    debugShowCheckedModeBanner: false,
    onGenerateRoute: (settings) {
      if (settings.name == "/") {
        return AnimationPageRoute(child: const SplashScreen(), settings: settings);
      }else if(settings.name == ScreenLogin().route){
        return AnimationPageRoute(child: const LoginScreen(), settings: settings);
      }else if(settings.name == ScreenRegister().route){
        return AnimationPageRoute(child: const RegisterScreen(), settings: settings);
      }else if(settings.name == ScreenHome().route){
        return AnimationPageRoute(child: const HomeScreen(), settings: settings);
      }else if(settings.name == ScreenCategoryProducts().route){
        return HeroAnimationPageRoute(child: const CategoryProductsScreen(), settings: settings);
      }else if(settings.name == ScreenProductDetail().route){
        return HeroAnimationPageRoute(child: const ProductDetailScreen(), settings: settings);
      }else if(settings.name == ScreenCart().route){
        return HeroAnimationPageRoute(child: const CartScreen(), settings: settings);
      }
      else {
        return AnimationPageRoute(child: const SplashScreen(), settings: settings);
      }
    },
    initialRoute: "/",
  ));
}
