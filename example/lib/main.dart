import 'package:flutter/material.dart';

import 'package:flutter_native_label/flutter_native_label.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          itemBuilder: (_, index) {
            return Container(
              margin: const EdgeInsets.all(8.0),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
