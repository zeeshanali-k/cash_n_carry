
abstract class Screen{
  String title;
  String route;

  Screen({required this.title,required this.route});

}

class ScreenLogin extends Screen{
  ScreenLogin() : super(title: "Login",route: "/login_screen");
}

class ScreenRegister extends Screen{
  ScreenRegister() : super(title: "Register",route: "/register_screen");
}

class ScreenHome extends Screen{
  ScreenHome() : super(title: "Home",route: "/home_screen");
}

class ScreenCategoryProducts extends Screen{
  ScreenCategoryProducts() : super(title: "Category Item",route: "/ScreenCategoryProducts");
}

class ScreenProductDetail extends Screen{
  ScreenProductDetail() : super(title: "Product Detail",route: "/ScreenProductDetail");
}

class ScreenCart extends Screen{
  ScreenCart() : super(title: "Cart",route: "/ScreenCart");
}