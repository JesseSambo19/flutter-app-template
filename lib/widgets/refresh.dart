
import 'package:flutter/material.dart';

class Refresh extends StatelessWidget {
  const Refresh({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: Pull down to refresh. ',
            ),
            Icon(Icons.arrow_downward_rounded),
          ],
        ),
      ),
    );
  }
}