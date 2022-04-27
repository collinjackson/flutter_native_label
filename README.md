# flutter_native_label

Flutter plugin wrapping `UILabel` on iOS. This is a workaround for flutter/flutter#28894.

Other platforms are not supported.

## Example Usage

```dart
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Text('Flutter Text 😊\n'),
        Flexible(child: NativeLabel('Native Label 😊\n')),
      ],
    );

  }
```

<video src="https://user-images.githubusercontent.com/394889/165560585-6112a48e-65bb-4357-9541-456cd137ed62.mov">
