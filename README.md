# flutter_native_label

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/donate/?cmd=_s-xclick&hosted_button_id=T95X77SLUMNBY)

Flutter plugin wrapping `UILabel`. This is a workaround for
- flutter/flutter#28894
- flutter/flutter#95644
- flutter/flutter#98342
- flutter/flutter#102484
- flutter/flutter#101569

Only iOS is supported.

## Example Usage
```dart
Scaffold(
  appBar: AppBar(
    title: const Text('Infinite list example'),
  ),
  body: CustomScrollView(
    slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            return Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NativeLabel(
                      "a 👍${List.filled(index, '👍aaa').join()}",
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.green,
                      ),
                      edgeInsetLeft: 10.0,
                      edgeInsetRight: 10.0,
                      edgeInsetTop: 10.0,
                      edgeInsetBottom: 10.0,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ],
  ),
);
```

## Screenshots

<img width="561" alt="Screen Shot 2022-06-16 at 12 05 33 PM" src="https://user-images.githubusercontent.com/394889/174146328-f201d30c-c855-4784-9dd1-2c6fd2ff8086.png">
<img width="561" alt="Screen Shot 2022-06-16 at 10 55 11 AM" src="https://user-images.githubusercontent.com/394889/174135392-c40a57f1-3d3a-4334-a9a5-7ddd4cc7ac0b.png">
