# flutter_native_label

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/donate/?cmd=_s-xclick&hosted_button_id=T95X77SLUMNBY)

Flutter plugin wrapping `UILabel` on iOS. This is a workaround for flutter/flutter#28894.

Other platforms are not supported.

## Example Usage

```dart
  ListView.builder(
    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
    itemBuilder: (_, index) {
      return Container(
        margin: EdgeInsets.all(8.0),
        child: NativeLabel(
          '''Demo 👍👍👍👍 👍👍👍👍 Multiline 👍👍👍😊😊😊 👍👍👍 '''
          '$index ${List.filled(index, '👍').join()}\n',
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
      ),
    );
  },
```

<video src="https://user-images.githubusercontent.com/394889/165588110-15dbaca8-8d92-466a-8416-fa05e560732b.mov">
