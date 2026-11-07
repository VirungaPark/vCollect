import 'package:flutter/material.dart';

void main() {
  runApp(const VCollectApp());
}

class VCollectApp extends StatelessWidget {
  const VCollectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'vCollect',
      home: Scaffold(body: Center(child: Text('Hello, world'))),
    );
  }
}
