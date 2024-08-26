import 'package:flutter/material.dart';

class TestImagePage extends StatelessWidget {
  const TestImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Image.network(
          'http://192.168.1.65:3000/public/images/Screenshot_20240821_090726.jpg'),
    );
  }
}
