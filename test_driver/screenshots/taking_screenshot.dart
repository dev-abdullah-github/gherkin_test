import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'dart:convert';
import 'package:meta/meta.dart';
// import '../flutter_world.dart';

class TakingScreenshot extends Hook {
  /// Run after a step has executed
  @override
  Future<void> onAfterStep(World world, String step, StepResult stepResult) async {
    if (stepResult.result == StepExecutionResult.fail || stepResult.result == StepExecutionResult.pass) {
      final screenshotData = await takeScreenshot(world);
      world.attach(screenshotData, 'image/png', step);
    }
  }

  @protected
  Future<String> takeScreenshot(World world) async {
    final bytes = await (world as FlutterWorld).driver.screenshot();

    return base64Encode(bytes);
  }
  
}