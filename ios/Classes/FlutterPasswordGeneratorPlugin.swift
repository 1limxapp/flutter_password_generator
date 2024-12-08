import Flutter
import UIKit
import CryptoKit

public class FlutterPasswordGeneratorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_password_generator", binaryMessenger: registrar.messenger())
    let instance = FlutterPasswordGeneratorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      do {
        switch call.method {
        case "generateSecureRandomData":
            try self.generateSecureRandomData(result: result)
        default:
          result(FlutterMethodNotImplemented)
        }
      } catch let error as NSError {
          result(FlutterError(
              code: "CAUGHT_ERROR",
              message:"\(error.domain), \(error.code), \(error.description)",
              details: nil))
      } catch {
          result(FlutterError(
              code: "CAUGHT_ERROR",
              message:"\(error)",
              details: nil))
      }
  }
    
    private func generateSecureRandomData(result: @escaping FlutterResult)  throws {
        if #available(iOS 13.0, *) {
            var newKey = SymmetricKey.init(size: SymmetricKeySize.bits256)

            let key = newKey.withUnsafeBytes {
                return Data(Array($0))
            }
            
            result(FlutterStandardTypedData(bytes: key))
        }
        result(FlutterError(code: "UNSUPPORTED_ALGORITHM", message:nil, details: nil))
    }
    
    private func parameterError(name: String) -> FlutterError {
        return FlutterError(code: "INVALID_ARGUMENT", message: "Parameter '\(name)' is missing or invalid", details: nil)
    }
}
