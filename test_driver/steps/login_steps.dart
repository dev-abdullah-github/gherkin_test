import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

import '../pages/login_page.dart';

class CheckloginWidgets extends GivenWithWorld<FlutterWorld> {
  CheckloginWidgets()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    LoginPage homePage = LoginPage(world.driver);
    await homePage.getEmailTextField();
    await homePage.getPasswordTextField();
    await homePage.getLoginbtn();
  }

  @override
  RegExp get pattern =>
      RegExp(r"I have emailfield and passwordfield and loginButton");
}

class EnterEmailAndPassword extends WhenWithWorld<FlutterWorld> {
  EnterEmailAndPassword()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    LoginPage homePage = LoginPage(world.driver);
    await homePage.clickEmailTextField();
    await homePage.enterEmail();
    await homePage.emailEnteredSuccessfully();
    await homePage.clickPasswordTextField();
    await homePage.enterPassword();
    await homePage.passwordEnteredSuccessfully();
  }

  @override
  RegExp get pattern =>
      RegExp(r"I fill the emailfield and password field");
}

class ClickLoginButton extends AndWithWorld<FlutterWorld> {
  ClickLoginButton()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    LoginPage homePage = LoginPage(world.driver);
    await homePage.clickLoginBtn();
  }

  @override
  RegExp get pattern =>
      RegExp(r"I tap the loginButton button");
}

class LoginSuccess extends ThenWithWorld<FlutterWorld> {
  LoginSuccess()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    LoginPage homePage = LoginPage(world.driver);
    await homePage.loginSuccess();
  }

  @override
  RegExp get pattern =>
      RegExp(r"I should have HomePage on screen");
}

class LogoutSucess extends ThenWithWorld<FlutterWorld> {
  LogoutSucess()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    LoginPage homePage = LoginPage(world.driver);
    await homePage.clickLogoutBtn();
    await homePage.backToLogin();
  }

  @override
  RegExp get pattern =>
      RegExp(r"I tap logout button and I back to loginscreen");
}

