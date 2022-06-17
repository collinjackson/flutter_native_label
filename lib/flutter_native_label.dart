import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class NativeLabel extends StatefulWidget {
  /// The text content of the label.
  final String text;

  /// Controls the [BoxDecoration] of the box behind the label.
  ///
  /// Default: null
  final BoxDecoration? decoration;

  /// Sets the style of the text being edited.
  ///
  /// Only `fontFamily`, `fontSize`, `fontWeight`, and `color` are supported.
  ///
  /// When using `fontFamily`, pass a complete font name including weight.
  /// In this case, `fontWeight` is ignored.
  ///
  /// Default: null
  final TextStyle? style;

  /// Sets the name of the font to be used.
  ///
  /// If this is set, the `fontWeight` of [style] is ignored.
  ///
  /// Default: null
  final String? fontName;

  /// Sets the spacing between characters of the text.
  ///
  /// Default: null
  final double? kern;

  /// Sets the spacing between lines of text.
  ///
  /// Default: null
  final double? lineSpacing;

  /// Sets the top edge insets.
  ///
  /// Default: 0.0
  final double edgeInsetTop;

  /// Sets the top edge insets.
  ///
  /// Default: 0.0
  final double edgeInsetBottom;

  /// Sets the top edge insets.
  ///
  /// Default: 0.0
  final double edgeInsetLeft;

  /// Sets the top edge insets.
  ///
  /// Default: 0.0
  final double edgeInsetRight;

  /// Whether user can use a long press gesture to copy.
  ///
  /// Default: false
  final bool copyable;

  const NativeLabel(this.text,
      {this.decoration,
      this.style,
      this.kern,
      this.lineSpacing,
      this.edgeInsetTop = 0.0,
      this.edgeInsetBottom = 0.0,
      this.edgeInsetLeft = 0.0,
      this.edgeInsetRight = 0.0,
      this.copyable = false,
      Key? key})
      : super(key: key);

  @override
  NativeLabelState createState() => NativeLabelState();
}

class NativeLabelState extends State<NativeLabel> {
  double _contentHeight = 16.0;
  double _contentWidth = 16.0;

  void _createMethodChannel(int nativeViewId) {
    MethodChannel channel = MethodChannel('flutter_native_label$nativeViewId');
    channel.invokeMethod('getContentDimensions').then((result) {
      double? width = result[0];
      double? height = result[1];
      if (!mounted) {
        return;
      }
      if (width != null)   {
        setState(() {
          _contentWidth = width;
        });
      }
      if (height != null) {
        setState(() {
          _contentHeight = height;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        decoration: widget.decoration,
        height: _contentHeight,
        width: _contentWidth,
        child: UiKitView(
          key: ValueKey([textScaleFactor, widget.text].join()),
          viewType: 'flutter_native_label',
          creationParamsCodec: const StandardMessageCodec(),
          creationParams: {
            'text': widget.text,
            'width': constraints.maxWidth,
            'textScaleFactor': textScaleFactor,
            if (widget.style != null && widget.style?.fontSize != null)
              'fontSize': widget.style!.fontSize,
            if (widget.style != null && widget.style?.fontWeight != null)
              'fontWeight': widget.style!.fontWeight,
            if (widget.style != null && widget.fontName != null)
              'fontName': widget.fontName,
            if (widget.style != null && widget.style?.color != null)
              'fontColor': {
                'red': widget.style?.color?.red,
                'green': widget.style?.color?.green,
                'blue': widget.style?.color?.blue,
                'alpha': widget.style?.color?.alpha,
              },
            if (widget.kern != null) 'kern': widget.kern,
            if (widget.lineSpacing != null) 'lineSpacing': widget.lineSpacing,
            'edgeInsetTop': widget.edgeInsetTop,
            'edgeInsetLeft': widget.edgeInsetLeft,
            'edgeInsetBottom': widget.edgeInsetBottom,
            'edgeInsetRight': widget.edgeInsetRight,
            'copyable': widget.copyable,
          },
          onPlatformViewCreated: _createMethodChannel,
        ),
      ),
    );
  }
}
