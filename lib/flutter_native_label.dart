import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class NativeLabel extends StatefulWidget {
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

  const NativeLabel(this.text, {
    this.decoration,
    this.style,
    Key? key
  }) : super(key: key);

  @override
  NativeLabelState createState() => NativeLabelState();
}

class NativeLabelState extends State<NativeLabel> {
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        decoration: widget.decoration,
        child: UiKitView(
          key: ValueKey([textScaleFactor, widget.text].join()),
          viewType: 'flutter_native_label',
          creationParamsCodec: const StandardMessageCodec(),
          creationParams: {
            "text": widget.text,
            "width": constraints.maxWidth,
            "textScaleFactor": textScaleFactor,
            if (widget.style != null && widget.style?.fontSize != null)
              "fontSize": widget.style!.fontSize,
            if (widget.style != null && widget.style?.fontWeight != null)
              "fontWeight": widget.style!.fontWeight,
            if (widget.style != null && widget.style?.fontWeight != null)
              "fontColor": {
                "red": widget.style?.color?.red,
                "green": widget.style?.color?.green,
                "blue": widget.style?.color?.blue,
                "alpha": widget.style?.color?.alpha,
              },
          },
        ),
      ),
    );
  }
}
