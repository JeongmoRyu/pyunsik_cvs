import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:frontend/models/product_list.dart';
import 'package:provider/provider.dart';
import 'package:frontend/pages/cart_page.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/pages/product_list_filtered_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/scrapbook_page.dart';
import 'package:frontend/pages/product_list_page.dart';
import 'package:frontend/pages/product_detail_page.dart';

import 'models/cart.dart';
import 'models/filter.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorListKey = GlobalKey<NavigatorState>(debugLabel: 'shellList');
final _shellNavigatorCartKey = GlobalKey<NavigatorState>(debugLabel: 'shellCart');
final _shellNavigatorScrapBookKey = GlobalKey<NavigatorState>(debugLabel: 'shellScrapBook');

final goRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomePage(),
              )
            )
          ]
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorListKey,
          routes: [
            GoRoute(
              path: '/list',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProductListPage(),
              ),
              routes: [
                GoRoute(
                  path: 'filtered',
                  builder: (context, state) => ProductFilteredPage(),
                )
              ]
            )
          ]
        ),
        StatefulShellBranch(
            navigatorKey: _shellNavigatorCartKey,
            routes: [
              GoRoute(
                path: '/cart',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CartPage(),
                ),
              )
            ]
        ),
        StatefulShellBranch(
            navigatorKey: _shellNavigatorScrapBookKey,
            routes: [
              GoRoute(
                path: '/scrapbook',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ScrapBook(),
                ),
              )
            ]
        )
      ]
    ),
    GoRoute(
      path: '/detail',
      builder: (BuildContext context, GoRouterState state) {
        return ProductDetailPage();
      },
    ),

  ]
);

// Stateful navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
      key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation')
  );
  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithNavigationBar(
      body: navigationShell,
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: _goBranch,
    );
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    return Scaffold(
      body: body,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: NavigationBar(
          onDestinationSelected: onDestinationSelected,
          selectedIndex: selectedIndex,
          destinations: <Widget>[
            const NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: '홈',
            ),
            const NavigationDestination(
              icon: Icon(Icons.list),
              label: '목록',
            ),
            NavigationDestination(
              selectedIcon: const Icon(Icons.interests),
              icon: Badge.count(count: cart.numberOfProducts, child: Icon(Icons.interests_outlined)),
              label: '조합',
            ),
            const NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_outline),
              label: '스크랩북',
            ),
          ],
        ),
      ),
    );
  }
}

  // /// The route configuration.
  // GoRouter router() {
  //   return GoRouter(
  //     initialLocation: '/',
  //     routes: <RouteBase>[
  //       GoRoute(
  //         path: '/',
  //         builder: (BuildContext context, GoRouterState state) {
  //           return MainPage();
  //         },
  //         routes: <RouteBase>[
  //           GoRoute(
  //             path: 'product_filtered',
  //             builder: (BuildContext context, GoRouterState state) {
  //               return ProductFilteredPage();
  //             },
  //           ),
  //           GoRoute(
  //             path: 'scrapbook',
  //             builder: (BuildContext context, GoRouterState state) {
  //               return ScrapBook();
  //             },
  //           ),
  //           GoRoute(
  //             path: 'ranking',
  //             builder: (BuildContext context, GoRouterState state) {
  //               return Ranking();
  //             },
  //           ),
  //           GoRoute(
  //             path: 'login',
  //             builder: (BuildContext context, GoRouterState state) {
  //               return Login();
  //             },
  //           ),
  //           GoRoute(
  //             path: 'signup',
  //             builder: (BuildContext context, GoRouterState state) {
  //               return Signup();
  //             },
  //           ),
  //           GoRoute(
  //             path: 'side_scroll',
  //             builder: (BuildContext context, GoRouterState state) {
  //               return SideScrollPage();
  //             },
  //           ),
  //           GoRoute(
  //             path: 'product_list',
  //             builder: (BuildContext context, GoRouterState state) {
  //               return ProductListPage();
  //             },
  //           ),
  //           GoRoute(
  //             path: 'product_detail',
  //             builder: (BuildContext context, GoRouterState state) {
  //               return ProductDetailPage();
  //             },
  //           ),
  //           GoRoute(
  //             path: 'cart_page',
  //             builder: (BuildContext context, GoRouterState state) {
  //               return CartPage();
  //             },
  //           )
  //
  //         ],
  //       ),
  //     ],
  //   );
  // }

void main() {
  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  runApp(const MyApp());
}

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Filter()),
        ChangeNotifierProxyProvider<Filter, ProductList>(
          create: (context) => ProductList(),
          update: (context, filter, productList) {
            if (productList == null) throw ArgumentError.notNull('productList');
            productList.filter = filter;
            return productList;
          },
        )
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: true,
        routerConfig: goRouter,
      ),
    );
  }
}

// class MainPage extends StatelessWidget {
//   const MainPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       debugShowCheckedModeBanner: true,
//       routerConfig: goRouter,
//     );
//   }
// }

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});
//
//   @override
//   State<MainPage> createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   // int currentPageIndex = 0;
//   int currentPageIndex = 0; //테스트용
//   void updateIndex(int index) {
//     setState(() {currentPageIndex = index;});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       bottomNavigationBar: NavBar(
//         selectedIndex: currentPageIndex,
//         onDestinationSelected: updateIndex,
//       ),
//       body: <Widget>[
//         Container(
//           alignment: Alignment.center,
//           child: HomePage(),
//         ),
//         Container(
//           alignment: Alignment.center,
//           child: ProductListPage(),
//         ),
//         Container(
//           alignment: Alignment.center,
//           child: CartPage(),
//         ),
//         Container(
//           alignment: Alignment.center,
//           child: Login(),
//         ),
//       ][currentPageIndex],
//     );
//   }
// }