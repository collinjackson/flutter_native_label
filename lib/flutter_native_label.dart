import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class NativeLabel extends StatelessWidget {
  const NativeLabel(this.text, {
    this.decoration,
    this.style,
    Key? key
  }) : super(key: key);

  /// The text content of the label.
  final String text;

  /// Controls the [BoxDecoration] of the box behind the label.
  ///
  /// Default: null
  final BoxDecoration? decoration;

  /// The style to use for the text being edited
  ///
  /// Only `fontSize`, `fontWeight`, and `color` are supported.
  ///
  /// Default: null
  final TextStyle? style;

  static const viewType = 'flutter_native_label';

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        decoration: decoration,
        child: UiKitView(
          viewType: NativeLabel.viewType,
          creationParamsCodec: const StandardMessageCodec(),
          creationParams: {
            "text": text,
            "width": constraints.maxWidth,
            "textScaleFactor": textScaleFactor,
            if (style != null && style?.fontSize != null)
              "fontSize": style!.fontSize,
            if (style != null && style?.fontWeight != null)
              "fontWeight": style!.fontWeight,
            if (style != null && style?.fontWeight != null)
              "fontColor": {
                "red": style?.color?.red,
                "green": style?.color?.green,
                "blue": style?.color?.blue,
                "alpha": style?.color?.alpha,
              },
          },
        ),
      ),
    );
  }
}
