import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final AlwaysStoppedAnimation<Color> color;

  LoadingIndicator({this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: color,
      ),
    );
  }
}
