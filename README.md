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
<img width="506" alt="Screen Shot 2022-04-27 at 7 43 19 AM" src="https://user-images.githubusercontent.com/394889/165546064-57595e88-1bb4-471d-bebb-73744aa35058.png">
