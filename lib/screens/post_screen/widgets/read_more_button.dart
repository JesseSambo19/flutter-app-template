
import 'package:flutter/material.dart';

import '../../../providers/post_provider.dart';

class ReadMoreButton extends StatelessWidget {
  const ReadMoreButton({
    super.key,
    required this.postProvider,
    required this.index,
  });

  final PostProvider postProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        postProvider.setPostIndex = index;
        Navigator.pushNamed(context, '/postDescription');
      },
      child: const Text('Read More'),
    );
  }
}