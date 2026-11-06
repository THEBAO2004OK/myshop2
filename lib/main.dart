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
        builder: (context, state) {
          final productId = state.pathParameters['productId']!;
          final product = ProductsManager().findById(productId);
          if (product == null) {
            return const Scaffold(
              body: Center(child: Text('Product not found')),
            );
          }
          return SafeArea(child: ProductDetailScreen(product));
        },
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const SafeArea(child: CartScreen()),
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
