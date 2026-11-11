import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mad_lab13/main.dart';

void main() {
  testWidgets('calculate button displays 80', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ScorePage()));
    expect(find.text('Score: 0'), findsOneWidget);
    await tester.tap(find.text('Calculate'));
    await tester.pump();
    expect(find.text('Score: 80'), findsOneWidget);
  });
}
