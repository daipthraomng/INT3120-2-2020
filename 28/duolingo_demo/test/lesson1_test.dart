import 'package:duolingo_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:duolingo_demo/screens/home.dart';

void main() {
  testWidgets('finds a Text widget', (WidgetTester tester) async {
    // Build an App with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(MyApp());
    // Tap the add button.
    await tester.tap(find.text('Cơ bản 1'));

    // Rebuild the widget after the state has changed.
    await tester.pump();
    // Find a widget that displays the letter 'H'.
    expect(find.byType(Text), findsOneWidget);
  });
}
