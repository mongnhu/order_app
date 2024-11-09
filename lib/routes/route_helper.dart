import 'package:food_delivery/features/cart/cart_page.dart';
import 'package:food_delivery/features/cart/check_out_page.dart';
import 'package:food_delivery/features/food/presentation/ui/popular_food_detail.dart';
import 'package:food_delivery/features/food/presentation/ui/recommend_food_detail.dart';
import 'package:food_delivery/features/home/presentation/ui/home_page.dart';
import 'package:food_delivery/features/pages/sign_in_page.dart';
import 'package:food_delivery/features/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String checkoutPage = "/checkout-page";
  static const String signInPage = "/sign-in-page";

  static String getSplashPage() => splashPage;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => cartPage;
  static String getCheckoutPage() => checkoutPage;
  static String getSignInPage() => signInPage;

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => const SplashScreen()),
    GetPage(
      name: signInPage,
      page: () => SignInPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          //print("popular food get called");
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          //print("popular food get called");
          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: checkoutPage,
        page: () {
          return CheckoutPage();
        },
        transition: Transition.fadeIn),
  ];
}
