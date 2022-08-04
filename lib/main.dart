import 'package:flutter/material.dart';
import 'package:flutter_application_one/core/store.dart';
import 'package:flutter_application_one/pages/home_page.dart';
import 'package:flutter_application_one/pages/login_page.dart';
import 'package:flutter_application_one/pages/register_page.dart';
import 'package:flutter_application_one/utils/routes.dart';
import 'package:flutter_application_one/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_strategy/url_strategy.dart';

import 'pages/cart_page.dart';
import 'pages/home_detail_page.dart';

void main() {
  setPathUrlStrategy();
  runApp(VxState(store: MyStore(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      //initialRoute: "/home",
      debugShowCheckedModeBanner: false,
      routeInformationParser: VxInformationParser(),
      routerDelegate: VxNavigator(routes: {
        MyRoutes.defaultRoute: (_, __) => MaterialPage(child: LoginPage()),
        MyRoutes.loginRoute: (_, __) => MaterialPage(child: LoginPage()),
        MyRoutes.registerRoute: (_, __) => MaterialPage(child: RegisterPage()),
        MyRoutes.homeRoute: (_, __) => MaterialPage(child: HomePage()),
        MyRoutes.cartRoute: (_, __) => MaterialPage(child: CartPage()),
        MyRoutes.homeDetailRoute: (uri, _) {
          final catalog = (VxState.store as MyStore)
              .catalog
              .getById(int.parse(uri.queryParameters["id"] as String));
          return MaterialPage(
              child: HomeDetail(
            catalog: catalog,
          ));
        },
      }),

      // routes: {
      // MyRoutes.defaultRoute: (context) =>
      //     LoginPage(), //set for dev default login
      // MyRoutes.loginRoute: (context) => LoginPage(),
      // MyRoutes.registerRoute: (context) => RegisterPage(),
      // MyRoutes.homeRoute: (context) => HomePage(),
      // MyRoutes.cartRoute: (context) => CartPage(),
      // },
    );
  }
}
