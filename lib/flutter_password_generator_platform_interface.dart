import 'flutter_password_generator_method_channel.dart';

abstract class FlutterPasswordGeneratorPlatform {
  static FlutterPasswordGeneratorPlatform _instance = MethodChannelFlutterPasswordGenerator();

  /// The default instance of [FlutterPasswordGeneratorPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPasswordGenerator].
  static FlutterPasswordGeneratorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPasswordGeneratorPlatform] when
  /// they register themselves.
  static set instance(FlutterPasswordGeneratorPlatform instance) {
    _instance = instance;
  }

  Future<List<int>?> generateSecureRandomData() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
