import 'package:flutter_driver/flutter_driver.dart';

class LoginPage {
  final emailTextFieldFinder = find.byValueKey('emailTextField');
  final passwordTextFieldFinder = find.byValueKey('passwordTextField');
  final loginBtnFinder = find.byValueKey('buttonKey');
  final homeScreenFinder = find.byValueKey('homeScreenKey');
  final logoutBtnFinder = find.byValueKey('logoutbtn');

  FlutterDriver _driver;

  //Constructor
  LoginPage(FlutterDriver driver) {
    this._driver = driver;
  }

  Future<void> getEmailTextField() async {
    return await _driver.waitFor(emailTextFieldFinder);
  }
   Future<void> getPasswordTextField() async {
    return await _driver.waitFor(passwordTextFieldFinder);
  }
   Future<void> getLoginbtn() async {
    return await _driver.waitFor(loginBtnFinder);
  }

  Future<void> clickEmailTextField() async {
    return await _driver.tap(emailTextFieldFinder);
  }

  Future<void> enterEmail() async {
    return await _driver.enterText('ma@mail.com');
  }

  Future<void> emailEnteredSuccessfully() async {
    return await _driver.waitFor(find.text('ma@mail.com'));
  }

  Future<void> clickPasswordTextField() async {
    return await _driver.tap(passwordTextFieldFinder);
  }

  Future<void> enterPassword() async {
    return await _driver.enterText('123456');
  }

  Future<void> passwordEnteredSuccessfully() async {
    return await _driver.waitFor(find.text('123456'));
  }

  Future<void> clickLoginBtn() async {
    return await _driver.tap(loginBtnFinder);
  }

  Future<void> loginSuccess() async {
    return await _driver.waitFor(homeScreenFinder);
  }

  Future<void> clickLogoutBtn() async {
    return await _driver.tap(logoutBtnFinder);
  }

  Future<void> backToLogin() async {
    return await _driver.waitFor(emailTextFieldFinder);
  }
}
