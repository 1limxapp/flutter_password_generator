
import 'flutter_password_generator_platform_interface.dart';
import 'dart:math';
import 'dart:typed_data';

class FlutterPasswordGenerator {
  final int length;
  final bool lowercaseIncluded;
  final bool uppercaseIncluded;
  final bool numbersIncluded;
  final bool symbolsIncluded;

  FlutterPasswordGenerator({
    this.length = 20,
    this.lowercaseIncluded = true,
    this.uppercaseIncluded = true,
    this.numbersIncluded = true,
    this.symbolsIncluded = true,
  });

  Future<List<int>?> generateSecureRandomData() {
    return FlutterPasswordGeneratorPlatform.instance.generateSecureRandomData();
  }

  Future<String> generatePassword() async {
    final lc = "abcdefghijklmnopqrstuvwxyz";
    final uc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final sym = "!@#\$%^&*()_+-=[]{}|;:,.<>/?";
    final num = "0123456789";
    String allChar = "";

    if (lowercaseIncluded) {
      allChar += lc;
    }

    if (uppercaseIncluded) {
      allChar += uc;
    }

    if (numbersIncluded) {
      allChar += num;
    }

    if (symbolsIncluded) {
      allChar += sym;
    }

    String pwd = "";
    for (int i = 0; i < length; i++) {
      pwd += allChar[(await secureRandom() * allChar.length).floor()];
    }

    final strongPassword = RegExp(r'(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{8,})');
    final mediumPassword = RegExp(r'((?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{6,}))|((?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9])(?=.{8,}))');

    if (strongPassword.hasMatch(pwd)) return pwd;
    if (mediumPassword.hasMatch(pwd)) return pwd;

    return pwd;
  }

  Future<double> secureRandom() async {
    try {
      // Generate secure random data
      final key128bit = await generateSecureRandomData();

      if (key128bit != null) {
        final buf = Uint8List.fromList(key128bit);

        // Ensure the buffer is at least 4 bytes long
        if (buf.length < 4) {
          throw Exception("Insufficient random data generated.");
        }

        final offset = Random().nextBool() ? 0 : buf.length - 4;
        final intVal = ByteData.sublistView(buf, offset, offset + 4).getUint32(0, Endian.little); // Convert bytes to an unsigned 32-bit integer
        final normalized = intVal / (pow(2, 32) - 1); // Scale to [0, 1)
        return normalized;
      } else {
        throw Exception("Insufficient random data generated.");
      }
    } catch (error) {
      print("Error generating secure random number: $error");
      throw error; // Rethrow or handle as needed
    }
  }
}
