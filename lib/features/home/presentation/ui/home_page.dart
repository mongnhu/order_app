import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/features/cart/cart_history.dart';
import 'package:food_delivery/features/cart/cart_page.dart';
import 'package:food_delivery/features/home/presentation/ui/main_food_page.dart';
import 'package:food_delivery/features/pages/profile_page.dart';
import 'package:food_delivery/features/pages/sign_in_page.dart';
import 'package:food_delivery/features/pages/sign_up_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:get/get.dart';
import 'package:food_delivery/controllers/auth_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authController = Get.find<AuthController>();
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const MainFoodPage(),
      const CartHistory(),
      const CartPage(),
      const ProFilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.archivebox_fill),
        title: "Archive",
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart_fill),
        title: "Cart",
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: "Me",
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isLoggedIn = authController.isLoggedIn.value;

      if (!isLoggedIn) {
        return SignInPage();
      }

      return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        padding: const EdgeInsets.only(top: 8),
        backgroundColor: Colors.white,
        isVisible: true,
        confineToSafeArea: true,
        navBarHeight: kBottomNavigationBarHeight,
        navBarStyle: NavBarStyle.style1,
      );
    });
  }
}
