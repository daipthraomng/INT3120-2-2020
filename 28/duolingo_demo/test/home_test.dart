import 'package:duolingo_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('finds a AppBar widget', (WidgetTester tester) async {
    // Build an App with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(MyApp());

    // Find a widget that displays the letter 'H'.
    expect(find.byType(AppBar), findsOneWidget);
  });
  testWidgets('finds a Text widget', (WidgetTester tester) async {
    // Build an App with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(MyApp());

    // Find a widget that displays the letter 'H'.
    expect(find.text('Cơ bản 1'), findsOneWidget);
    expect(find.text('Cơ bản 2'), findsOneWidget);
  });

  testWidgets('finds a BottomNavigationBarItem widget',
      (WidgetTester tester) async {
    // Build an App with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(MyApp());

    // Find a widget that displays the letter 'H'.
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
  testWidgets('finds a widget using a Key', (WidgetTester tester) async {
    // Define the test key.
    final testKey = Key('K');

    // Build a MaterialApp with the testKey.
    await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

    // Find the MaterialApp widget using the testKey.
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('finds a specific instance', (WidgetTester tester) async {
    final childWidget = Padding(padding: EdgeInsets.zero);

    // Provide the childWidget to the Container.
    await tester.pumpWidget(Container(child: childWidget));

    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childWidget), findsOneWidget);
  });
}
