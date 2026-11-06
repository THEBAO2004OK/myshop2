import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myshop/main.dart';

void main() {
  testWidgets('orders screen expands an order', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Your Orders'), findsOneWidget);
    expect(find.text('\$59.98'), findsOneWidget);
    expect(find.text('24/06/2022 10:33'), findsOneWidget);
    expect(find.text('Red Shirt'), findsNothing);

    await tester.tap(find.byIcon(Icons.expand_more));
    await tester.pump();

    expect(find.text('Red Shirt'), findsOneWidget);
    expect(find.text('2 x \$29.99'), findsOneWidget);
    expect(find.byIcon(Icons.expand_less), findsOneWidget);
  });
}
