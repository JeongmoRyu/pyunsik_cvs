import 'package:flutter/material.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/signup_page.dart';
import 'package:provider/provider.dart';
import 'package:frontend/pages/cart_page.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/pages/product_list_filtered_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/scrapbook_page.dart';
import 'package:frontend/pages/product_list_page.dart';
import 'package:frontend/pages/product_detail_page.dart';
import 'package:frontend/pages/combination_detail_page.dart';
import 'package:frontend/pages/search_page.dart';
import 'package:frontend/pages/mypage.dart';
import 'package:frontend/util/auth_api.dart';

import 'models/cart.dart';
import 'models/filter.dart';
import 'models/user.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorListKey = GlobalKey<NavigatorState>(debugLabel: 'shellList');
final _shellNavigatorCartKey = GlobalKey<NavigatorState>(debugLabel: 'shellCart');
final _shellNavigatorScrapBookKey = GlobalKey<NavigatorState>(debugLabel: 'shellScrapBook');

final goRouter = GoRouter(
  initialLocation: '/',
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
              path: '/',
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
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return ProductDetailPage(productId: state.extra as int,);
      },
    ),
    GoRoute(
      path: '/login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
      },
    ),
    GoRoute(
      path: '/signup',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return SignupPage();
      },
    ),
    GoRoute(
      path: '/combination_detail',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return CombinationDetailPage();
      },
    ),
    GoRoute(
      path: '/search',
      builder: (BuildContext context, GoRouterState state) {
        return SearchPage();
      },
    ),
    GoRoute(
      path: '/mypage',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return MyPage();
      },
    )


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
    var user = context.watch<User>();

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

void main() {
  // turn off the # in the URLs on the web
  // usePathUrlStrategy();
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
        ChangeNotifierProvider(create: (context) => User()),
        ChangeNotifierProvider(create: (context) => Filter()),
        // ChangeNotifierProxyProvider<Filter, ProductList>(
        //   create: (context) => ProductList(),
        //   update: (context, filter, productList) {
        //     if (productList == null) throw ArgumentError.notNull('productList');
        //     productList.filter = filter;
        //     return productList;
        //   },
        // )
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: true,
        routerConfig: goRouter,
      ),
    );
  }
}
