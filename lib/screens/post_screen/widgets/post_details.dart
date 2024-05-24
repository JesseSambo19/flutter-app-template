
import 'package:flutter/material.dart';

import '../../../models/post_model.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title), //! Displaying post title
      subtitle: Text(
        post.body,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ), //! Displaying post body
    );
  }
}