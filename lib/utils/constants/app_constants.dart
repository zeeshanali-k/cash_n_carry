import 'package:cash_n_carry/domain/models/category.dart';

class AppConstants{
  static const appFont="assets/fonts/abc";
  static const appName="Cash & Carry";
  static const appLogo="assets/images/logo.png";

  // static const BASE_URL="http://google.com/";

  static const usersCollections = "users";

  static const heroCategoryIcon = "category_icon";
  static const heroProductIcon = "product_icon";
  static const heroProductCard = "product_card";

  static const appDatabase = "cash_n_carry_database";

  static List<Category> getCategoriesList(){
    return const [
      Category(name: "Vegetables", icon: "assets/category_icons/vegetables.png", id: 1, itemsCount: 100),
      Category(name: "Fruits", icon: "assets/category_icons/fruits.png", id: 2, itemsCount: 70),
      Category(name: "Clothes", icon: "assets/category_icons/clothes.png", id: 3, itemsCount: 35),
      Category(name: "Appliances", icon: "assets/category_icons/appliances.png", id: 4, itemsCount: 23),
      Category(name: "Tools", icon: "assets/category_icons/tools.png", id: 5, itemsCount: 55),
      Category(name: "Toys", icon: "assets/category_icons/toys.png", id: 6, itemsCount: 66),
      Category(name: "Books", icon: "assets/category_icons/books.png", id: 7, itemsCount: 90),
      Category(name: "Cold Drinks", icon: "assets/category_icons/cold_drinks.png", id: 8, itemsCount: 200)
    ];
  }

}