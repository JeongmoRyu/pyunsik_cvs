import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/pages/cart_page.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/pages/product_filtered_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/scrapbook_page.dart';
import 'package:frontend/molecules/ranking.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/signup_page.dart';
import 'package:frontend/pages/side_scroll_page.dart';
import 'package:frontend/pages/product_list_page.dart';
import 'package:frontend/pages/product_detail_page.dart';
import 'package:frontend/pages/cart_page.dart';
import 'package:frontend/pages/api_temp.dart';

import 'package:frontend/pages/combination_detail_page.dart';

import 'models/cart.dart';
import 'molecules/nav_bar.dart';


void main() => runApp(const MyApp());

/// The route configuration.
GoRouter router() {
  return GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return MainPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'product_filtered',
            builder: (BuildContext context, GoRouterState state) {
              return ProductFilteredPage();
            },
          ),
          GoRoute(
            path: 'scrapbook',
            builder: (BuildContext context, GoRouterState state) {
              return ScrapBook();
            },
          ),
          GoRoute(
            path: 'ranking',
            builder: (BuildContext context, GoRouterState state) {
              return Ranking();
            },
          ),
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return Login();
            },
          ),
          GoRoute(
            path: 'signup',
            builder: (BuildContext context, GoRouterState state) {
              return Signup();
            },
          ),
          GoRoute(
            path: 'side_scroll',
            builder: (BuildContext context, GoRouterState state) {
              return SideScrollPage();
            },
          ),
          GoRoute(
            path: 'product_list',
            builder: (BuildContext context, GoRouterState state) {
              return ProductListPage();
            },
          ),
          GoRoute(
            path: 'product_detail',
            builder: (BuildContext context, GoRouterState state) {
              return ProductDetailPage();
            },
          ),
          GoRoute(
            path: 'cart_page',
            builder: (BuildContext context, GoRouterState state) {
              return CartPage();
            },
          ),
          GoRoute(
            path: 'tempapi',
            builder: (BuildContext context, GoRouterState state) {
              return ApiTemp();
            },
          ),
          GoRoute(
            path: 'combination_detail',
            builder: (BuildContext context, GoRouterState state) {
              return CombinationDetailPage();
            },
          )



        ],
      ),
    ],
  );
}

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // int currentPageIndex = 0;
  int currentPageIndex = 0; //테스트용
  void updateIndex(int index) {
    setState(() {currentPageIndex = index;});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: NavBar(
        currentPageIndex: currentPageIndex,
        callback: updateIndex,
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: HomePage(),
        ),
        Container(
          alignment: Alignment.center,
          child: ProductListPage(),
        ),
        Container(
          alignment: Alignment.center,
          child: CartPage(),
        ),
        Container(
          alignment: Alignment.center,
          child: Login(),
        ),
      ][currentPageIndex],
    );
  }
}