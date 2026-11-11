import 'package:flutter_test/flutter_test.dart';
import 'package:csc303_mad/main.dart';

void main() {
  testWidgets('counter increments when button is tapped', (tester) async {
    await tester.pumpWidget(const FirstPhoneApp());
    expect(find.text('Button tapped 0 times'), findsOneWidget);
    await tester.tap(find.text('Tap on my phone'));
    await tester.pump();
    expect(find.text('Button tapped 1 times'), findsOneWidget);
  });
}
