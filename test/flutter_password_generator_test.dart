import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_password_generator/flutter_password_generator.dart';
import 'package:flutter_password_generator/flutter_password_generator_platform_interface.dart';
import 'package:flutter_password_generator/flutter_password_generator_method_channel.dart';

class MockFlutterPasswordGeneratorPlatform
    implements FlutterPasswordGeneratorPlatform {

  @override
  Future<List<int>?> generateSecureRandomData() => Future.value([42]);
}

void main() {
  final FlutterPasswordGeneratorPlatform initialPlatform = FlutterPasswordGeneratorPlatform.instance;

  test('$MethodChannelFlutterPasswordGenerator is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPasswordGenerator>());
  });

  test('generateSecureRandomData', () async {
    FlutterPasswordGenerator flutterPasswordGeneratorPlugin = FlutterPasswordGenerator();
    MockFlutterPasswordGeneratorPlatform fakePlatform = MockFlutterPasswordGeneratorPlatform();
    FlutterPasswordGeneratorPlatform.instance = fakePlatform;

    expect(await flutterPasswordGeneratorPlugin.generateSecureRandomData(), [42]);
  });
}
