import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myshop/main.dart';

void main() {
  testWidgets('drawer navigates between app routes', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('MyShop'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.text('Hello Friend!'), findsOneWidget);
    expect(find.text('Orders'), findsOneWidget);

    await tester.tap(find.text('Orders'));
    await tester.pumpAndSettle();
    expect(find.text('Your Orders'), findsOneWidget);
  });
}
