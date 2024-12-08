# flutter_password_generator

Generate strong passwords for flutter applications using native function without dependencies

## Requirements

iOS >= 13.0\
Android >= 26


## Installation

```sh
flutter pub add flutter_password_generator
```

## Usage


```js
import 'package:flutter_chacha20_poly1305/flutter_chacha20_poly1305.dart';

final _flutterPasswordGeneratorPlugin = FlutterPasswordGenerator(length: 24);
final key = await _flutterPasswordGeneratorPlugin.generatePassword();
print('Generated password: ${pwd}');
// Generated password: {password: 8M:a[1>]8oXFCyPF2xa0BrM], strength: strong}
```

## Methods

#### `generatePassword(): <String>`
if no passwordConfig object is passed when init FlutterPasswordGenerator(password_config);, it'll use the default config object:

```js
(
  length: 20,
  lowercaseIncluded: true,
  uppercaseIncluded: true,
  numbersIncluded: true,
  symbolsIncluded: true
)
```

## Author

Hayr Hotoca | [@1limxapp](https://twitter.com/1limxapp)\
This package is used in my cross-platform app called [1LimX](https://1limx.com/)
## License

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---