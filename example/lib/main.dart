import 'package:flutter/material.dart';

import 'package:flutter_native_label/flutter_native_label.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(_) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Native Label examples'),
        ),
        body: Builder(
          builder: (context) {
            return ListView(
              children: [
                ListTile(
                  title: const Text('Intrinsic size test'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IntrinsicSizeExample(),
                        ));
                  },
                ),
                ListTile(
                  title: const Text('Infinite list test'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InfiniteListExample(),
                        ));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class IntrinsicSizeExample extends StatelessWidget {
  const IntrinsicSizeExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intrinsic size example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Flexible(
                  child: NativeLabel(
                    'Hello world!',
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.green,
                    ),
                    edgeInsetLeft: 40.0,
                    edgeInsetRight: 40.0,
                    edgeInsetTop: 40.0,
                    edgeInsetBottom: 40.0,
                  ),
                ),
                SizedBox(width: 40.0),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 40.0),
                Flexible(
                  child: NativeLabel(
                    'The quick brown fox jumps over the lazy dog',
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
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Flexible(
                  child: NativeLabel(
                    "👍👍👍 I couldn't agree more",
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.green,
                    ),
                    edgeInsetLeft: 20.0,
                    edgeInsetRight: 20.0,
                    edgeInsetTop: 20.0,
                    edgeInsetBottom: 20.0,
                  ),
                ),
                SizedBox(width: 40.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfiniteListExample extends StatelessWidget {
  const InfiniteListExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  }
}
