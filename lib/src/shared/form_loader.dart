import 'package:flutter/material.dart';

class FormLoader extends StatelessWidget {
  const FormLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
    );
  }
}
