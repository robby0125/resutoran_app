import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:resutoran_app/core/di/injection.dart';
import 'package:resutoran_app/core/presentation/pages/home_screen.dart';
import 'package:resutoran_app/core/presentation/pages/user_login_screen.dart';
import 'package:resutoran_app/core/presentation/pages/user_register_screen.dart';
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
          primaryColor: Color(0xFFFD9228),
        ),
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: TABLET),
          ],
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (_) => HomeScreen(),
          UserLoginScreen.routeName: (_) => UserLoginScreen(),
          UserRegisterScreen.routeName: (_) => UserRegisterScreen(),
        },
      ),
    );
  }
}
