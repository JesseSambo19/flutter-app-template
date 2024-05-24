
import 'package:flutter/material.dart';

class InternetConnection extends StatelessWidget {
  const InternetConnection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off),
            Text(
              'Please connect to the internet.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
  }
}