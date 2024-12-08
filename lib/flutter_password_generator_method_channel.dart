import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_password_generator_platform_interface.dart';

/// An implementation of [FlutterPasswordGeneratorPlatform] that uses method channels.
class MethodChannelFlutterPasswordGenerator extends FlutterPasswordGeneratorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_password_generator');

  @override
  Future<List<int>?> generateSecureRandomData() async {
    final version = await methodChannel.invokeMethod<List<int>>('generateSecureRandomData');
    return version;
  }
}
