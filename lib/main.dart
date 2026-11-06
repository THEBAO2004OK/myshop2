import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'ui/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/products',
    routes: [
      GoRoute(
        path: '/products',
        builder: (context, state) =>
            const SafeArea(child: ProductsOverviewScreen()),
      ),
      GoRoute(
        path: '/products/:productId',
        pageBuilder: (context, state) {
          final productId = state.pathParameters['productId']!;
          final product = ProductsManager().findById(productId);
          if (product == null) {
            return const NoTransitionPage(
              child: Scaffold(body: Center(child: Text('Product not found'))),
            );
          }
          return CustomTransitionPage(
            key: state.pageKey,
            child: SafeArea(child: ProductDetailScreen(product)),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final curvedAnimation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOutCubic,
                  );
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(curvedAnimation);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: '/cart',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SafeArea(child: CartScreen()),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCubic,
            );

            return FadeTransition(opacity: curvedAnimation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const SafeArea(child: OrdersScreen()),
      ),
      GoRoute(
        path: '/my-products',
        builder: (context, state) =>
            const SafeArea(child: UserProductsScreen()),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.purple,
      secondary: Colors.deepOrange,
      surface: Colors.white,
      surfaceTint: Colors.grey[200],
    );

    final themeData = ThemeData(
      fontFamily: 'Lato',
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shadowColor: colorScheme.shadow,
      ),
      dialogTheme: DialogThemeData(
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(color: colorScheme.onSurface, fontSize: 20),
      ),
    );

    return MaterialApp.router(
      title: 'MyShop',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      routerConfig: _router,
    );
  }
}
