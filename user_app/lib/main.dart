import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:resutoran_app/common/style.dart';
import 'package:resutoran_app/core/di/injection.dart';
import 'package:resutoran_app/core/presentation/pages/detail_screen.dart';
import 'package:resutoran_app/core/presentation/pages/login_screen.dart';
import 'package:resutoran_app/core/presentation/pages/main_screen.dart';
import 'package:resutoran_app/core/presentation/pages/register_screen.dart';
import 'package:resutoran_app/core/presentation/provider/auth_provider.dart';
import 'package:resutoran_app/core/presentation/provider/restaurant_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Injection.init();
  runApp(Resutoran());
}

class Resutoran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Get.find<RestaurantProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => Get.find<AuthProvider>(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Resutoran',
        theme: ThemeData(
          primaryColor: Style.primaryColor,
          textTheme: Style.textTheme,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1280,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480),
            ResponsiveBreakpoint.autoScale(800),
            ResponsiveBreakpoint.resize(1280),
          ],
        ),
        initialRoute: MainScreen.routeName,
        routes: {
          MainScreen.routeName: (_) => MainScreen(),
          LoginScreen.routeName: (_) => LoginScreen(),
          RegisterScreen.routeName: (_) => RegisterScreen(),
          DetailScreen.routeName: (context) => DetailScreen(
                restaurant: ModalRoute.of(context).settings.arguments,
              ),
        },
      ),
    );
  }
}
