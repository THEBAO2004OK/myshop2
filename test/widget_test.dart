import 'package:flutter_test/flutter_test.dart';

import 'package:myshop/main.dart';

void main() {
  testWidgets('cart screen displays the sample cart', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Your Cart'), findsOneWidget);
    expect(find.text('Total'), findsOneWidget);
    expect(find.text('\$59.98'), findsOneWidget);
    expect(find.text('Red Shirt'), findsOneWidget);
    expect(find.text('2 x \$29.99'), findsOneWidget);
    expect(find.text('ORDER NOW'), findsOneWidget);
  });
}
