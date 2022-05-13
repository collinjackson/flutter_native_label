# flutter_native_label

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/donate/?cmd=_s-xclick&hosted_button_id=T95X77SLUMNBY)

Flutter plugin wrapping `UILabel`. This is a workaround for
- flutter/flutter#28894
- flutter/flutter#95644
- flutter/flutter#98342
- flutter/flutter#102484
- flutter/flutter#101569

Only iOS platform is supported.

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
        edgeInsetTop: 10.0,
        edgeInsetLeft: 10.0,
        edgeInsetBottom: 10.0,
        edgeInsetRight: 10.0,
        lineSpacing: 20.0,
        kern: 5.0,
        copyable: true,
      ),
    );
  },
```

## Video

https://user-images.githubusercontent.com/394889/167484748-bc01b3dd-fce5-45d1-9d1f-e7521bfd9a4b.mov
