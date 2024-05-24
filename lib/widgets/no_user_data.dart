
import 'package:flutter/material.dart';

class NoUserData extends StatelessWidget {
  const NoUserData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text('No user data available.'),
      ),
    );
  }
}