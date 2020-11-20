import 'package:duolingo_demo/main.dart';
import 'package:duolingo_demo/screens/lesson1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:duolingo_demo/screens/home.dart';
import './mock.dart';

void main() {
  setupCloudFirestoreMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  Widget buildTestableWidget(Widget widget) {
    // https://docs.flutter.io/flutter/widgets/MediaQuery-class.html
    return new MediaQuery(
        data: new MediaQueryData(), child: new MaterialApp(home: widget));
  }

  test('test passing parameter', () {
    expect(Lesson1('01', 'home1').createState().lesson, '01');
    expect(Lesson1('01', 'home1').createState().homeIndex, 'home1');
  });

  // testWidgets("test building lesson1", (WidgetTester tester) async {
  //   await tester.pumpWidget(buildTestableWidget(Lesson1('01', 'home1')));
  // });
}
