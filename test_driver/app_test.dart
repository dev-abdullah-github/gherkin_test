import 'package:flutter_driver/flutter_driver.dart';
// import 'package:screenshots/capture_screen.dart';
// import 'package:screenshots/config.dart';
import 'package:test/test.dart';
// import 'package:screenshots/screenshots.dart';

void main() {
  group('login test', () {
    // First, define the Finders. We can use these to locate Widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final emailTextFieldFinder = find.byValueKey('emailTextField');
    final passwordTextFieldFinder = find.byValueKey('passwordTextField');
    final loginBtnFinder = find.byValueKey('buttonKey');
    final homeScreenFinder = find.byValueKey('homeScreenKey');
    final logoutbtnFinder = find.byValueKey('logoutbtn');

    // final config = Config();

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    Future<void> delay([int milliseconds = 250]) async {
      await Future<void>.delayed(Duration(milliseconds: milliseconds));
    }

    test('check flutter driver health', () async {
      final health = await driver.checkHealth();
      expect(health.status, HealthStatus.ok);
    });
    test('a location name appears in location list', () async {
      // Use the `driver.tap` method to find the input field.
      await driver.waitFor(emailTextFieldFinder);
      //delay for record
      await delay(750);
      await driver.tap(emailTextFieldFinder);
      // verify that your input field is empty.
      await driver.waitFor(find.text(''));
      // Use the 'driver.enterText' method to enter the text to your input field.
      await driver.enterText('ma@mail.com');
      // verify that your input field contains entered text from the step above.
      await driver.waitFor(find.text('ma@mail.com'));
      await driver.tap(passwordTextFieldFinder);
      await driver.waitFor(find.text(''));
      await driver.enterText('123456');
      await driver.waitFor(find.text('123456'));
      await delay(750);
      await driver.tap(loginBtnFinder);
      await driver.waitFor(homeScreenFinder);
      await driver.tap(logoutbtnFinder);
      await driver.waitFor(emailTextFieldFinder);
      // await screenshot(driver, config, 'testing');
    });

    // NOTE one more test to come in the next step!
  });
}
