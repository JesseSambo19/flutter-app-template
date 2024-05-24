import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//! Importing post provider and model
import '../../providers/post_provider.dart';
import '../../models/post_model.dart';
import 'widgets/full_post_details.dart';

//! Defining PostScreen widget
class PostDescriptionScreen extends StatefulWidget {
  const PostDescriptionScreen({super.key});

  @override
  PostDescriptionScreenState createState() => PostDescriptionScreenState();
}

//! State class for PostDescriptionScreen widget
class PostDescriptionScreenState extends State<PostDescriptionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Post Description'),
      ), //! AppBar with title
      body: Center(
        child: Consumer<PostProvider>(
          //! Using Consumer to rebuild parts of the UI that depend on post data
          builder: (context, postProvider, child) {
            //! Checking if posts are still loading
            if (postProvider.posts.isEmpty) {
              return const CircularProgressIndicator(); //! Displaying a loading indicator
            }
            final PostModel post = postProvider
                .posts[postProvider.getPostIndex]; //! Extracting post object
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: Column(
                    children: [
                      FullPostDetails(post: post),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
