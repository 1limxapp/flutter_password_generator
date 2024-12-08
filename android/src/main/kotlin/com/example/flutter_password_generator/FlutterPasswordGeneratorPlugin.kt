package com.example.flutter_password_generator

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import javax.crypto.KeyGenerator
import javax.crypto.SecretKey

/** FlutterPasswordGeneratorPlugin */
class FlutterPasswordGeneratorPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_password_generator")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "generateSecureRandomData") {
      generateSecureRandomData(result);
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun generateSecureRandomData(result: Result) {
    try {
      val keygen = KeyGenerator.getInstance("ChaCha20")
      keygen.init(128)
      val key: SecretKey = keygen.generateKey()

      result.success(key.encoded)
    } catch (e: Exception) {
      result.error("Generate symmetric key", e.localizedMessage, e)
    }
  }
}
