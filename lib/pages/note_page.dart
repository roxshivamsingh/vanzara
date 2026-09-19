import 'package:flutter/material.dart';

class NotePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [ElevatedButton(onPressed: () {}, child: Text("Text"))],
      ),
    );
  }
}
