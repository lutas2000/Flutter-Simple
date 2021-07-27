import 'package:flutter/material.dart';

class CountersTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: Text('Counter')),
        Expanded(child: Text('Processing')),
        Expanded(child: Text('Proceed')),
      ],
    );
  }
}
