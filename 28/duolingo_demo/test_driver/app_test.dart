// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Duolingo Demo', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    // home screen
    final homeIcon = find.byValueKey('home2');

    // lesson1 screen
    final image1 = find.byValueKey('image1');

    // lesson2 screen
    final answer1 = find.byValueKey('answer1');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Click home icon', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.

      // home
      await driver.waitFor(find.text("Về đích"));
      await driver.tap(homeIcon);
      await driver.waitFor(find.text("KIỂM TRA"));
      await Future.delayed(Duration(milliseconds: 1000), () {});
    });
    test('Click image lesson 1', () async {
      // lesson 1
      await driver.tap(image1);
      await Future.delayed(Duration(milliseconds: 1000), () {});
      await driver.tap(find.text("KIỂM TRA"));
      await Future.delayed(Duration(milliseconds: 1000), () {});
      await driver.tap(find.text("TIẾP TỤC"));
      await Future.delayed(Duration(milliseconds: 1000), () {});
      await driver.tap(image1);
      await Future.delayed(Duration(milliseconds: 1000), () {});
      await driver.tap(find.text("KIỂM TRA"));
      await Future.delayed(Duration(milliseconds: 1000), () {});
      await driver.tap(find.text("TIẾP TỤC"));
      await Future.delayed(Duration(milliseconds: 1000), () {});
    });
    test('Click answer lesson 2', () async {
      // lesson2
      await driver.tap(answer1);
      await Future.delayed(Duration(milliseconds: 1000), () {});
      await driver.tap(find.text("KIỂM TRA"));
      await Future.delayed(Duration(milliseconds: 1000), () {});
      await driver.tap(find.text("TIẾP TỤC"));
      await Future.delayed(Duration(milliseconds: 1000), () {});
      await driver.tap(answer1);
      await Future.delayed(Duration(milliseconds: 1000), () {});
      await driver.tap(find.text("KIỂM TRA"));
      await Future.delayed(Duration(milliseconds: 1000), () {});
      await driver.tap(find.text("TIẾP TỤC"));
      await Future.delayed(Duration(milliseconds: 1000), () {});
    });
  });
}
