
import 'package:flutter/material.dart';

import '../../../models/post_model.dart';

class FullPostDetails extends StatelessWidget {
  const FullPostDetails({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        post.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ), //! Displaying post title
      subtitle: Text(
        post.body,
      ), //! Displaying post body
    );
  }
}
