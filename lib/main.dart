import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
//import 'package:food_delivery/features/cart/presemtation/ui/cart.dart';
import 'package:food_delivery/features/home/presentation/ui/main_food_page.dart';
import 'package:food_delivery/features/splash/splash_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencis.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(540, 960),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetBuilder<PopularProductController>(builder: (_) {
          return GetBuilder<RecommendedProductController>(builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              // theme: ThemeData(
              //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              //   useMaterial3: true,
              //   fontFamily: 'Mulish',
              // ),
              //home: SplashScreen(),
              initialRoute: RouteHelper.getSplashPage(),
              getPages: RouteHelper.routes,
            );
          });
        });
      },
    );
  }
}
