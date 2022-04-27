import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class NativeLabel extends StatelessWidget {
  const NativeLabel(this.text, { this.decoration, Key? key }) : super(key: key);

  final String text;
  final BoxDecoration? decoration;

  static const viewType = 'flutter_native_label';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, layout) => Container(
        decoration: decoration,
        child: UiKitView(
          viewType: NativeLabel.viewType,
          creationParamsCodec: const StandardMessageCodec(),
          creationParams: _buildCreationParams(layout),
        ),
      ),
    );
  }

  Map<String, dynamic> _buildCreationParams(BoxConstraints constraints) {
    Map<String, dynamic> params = {
      "text": text,
      "width": constraints.maxWidth,
    };

    return params;
  }
}
