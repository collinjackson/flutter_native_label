// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:async';

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
