import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//! Importing post provider and model
import '../../providers/app_provider.dart';
import '../../providers/post_provider.dart';
import '../../models/post_model.dart';

//! Importing utils
import '../../utils/check_connectivity.dart';
import '../../widgets/internet_connection.dart';
import '../../widgets/loading.dart';
import '../../widgets/no_data.dart';
import '../../widgets/refresh.dart';
import 'widgets/post_details.dart';
import 'widgets/read_more_button.dart';

//! Defining PostScreen widget
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  PostScreenState createState() => PostScreenState();
}

//! State class for PostScreen widget
class PostScreenState extends State<PostScreen> {
  late AppProvider appProvider;
  late PostProvider postProvider;

//! this will initially be empty, but it will used only once when navigating is on this screen
  late Future<List<PostModel>> postFuture;

  @override
  void initState() {
    super.initState();
    checkConnectivity(context);
    //! this will be called only once on this screen
    postFuture = Provider.of<PostProvider>(context, listen: false).fetchPosts();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppProvider>(context, listen: false)
          .fetchDataPeriodically(context, () async {
        postFuture =
            Provider.of<PostProvider>(context, listen: false).fetchPosts();
      });
    });
  }

  Future refreshUI() async {
    setState(() {
      postFuture =
          Provider.of<PostProvider>(context, listen: false).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
    postProvider = Provider.of<PostProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Posts'),
      ), //! AppBar with title
      body: appProvider.getIsConnected
          ? RefreshIndicator(
              onRefresh: refreshUI,
              //! in order for RefreshIndicator to work, wrap the child widget with a ListView e.g. FutureBuilder
              //! if the children of the child widget use a ListView, then wrap the individual widgets with a ListView
              //! otherwise RefreshIndicator won't work for all widgets in the widget tree
              //!  Do not use more than one ListView widget otherwise there will an error
              child: FutureBuilder<List<PostModel>>(
                //! this will be called only once on this screen, if exiting the screen and coming back
                //! then it will be called again
                future: postFuture,
                //! will be called more than once
                // future: postProvider.fetchPosts(),
                builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView(
                      children: const [
                        Loading(),
                      ],
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return ListView(
                        children: const [
                          Refresh(),
                        ],
                      );
                    } else if (snapshot.hasData) {
                      if (kDebugMode) {
                        print('Snapshot data: ${snapshot.data}');
                      }

                      final List<PostModel> post =
                          snapshot.data!; //! Extracting post object

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                          itemCount: post.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PostDetails(post: post[index]),
                                  ReadMoreButton(
                                    postProvider: postProvider,
                                    index: index,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                  return const NoData();
                },
              ),
            )
          : const InternetConnection(),
    );
  }
}


//! old code
// //
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// //! Importing post provider and model
// import '../../providers/post_provider.dart';
// import '../../models/post_model.dart';
// import 'widgets/post_details.dart';
// import 'widgets/read_more_button.dart';

// //! Defining PostScreen widget
// class PostScreen extends StatefulWidget {
//   const PostScreen({super.key});

//   @override
//   PostScreenState createState() => PostScreenState();
// }

// //! State class for PostScreen widget
// class PostScreenState extends State<PostScreen> {
//   @override
//   void initState() {
//     super.initState();
//     //! Fetching post data when the screen initializes
//     Provider.of<PostProvider>(context, listen: false).fetchPosts();
//   }

//   Future refreshUI() async {
//     setState(() {
//       // postFuture =
//           Provider.of<PostProvider>(context, listen: false).fetchPosts();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Posts'),
//       ), //! AppBar with title
//       body: Center(
//         child: Consumer<PostProvider>(
//           //! Using Consumer to rebuild parts of the UI that depend on post data
//           builder: (context, postProvider, child) {
//             //! Checking if posts are still loading
//             if (postProvider.posts.isEmpty) {
//               return const CircularProgressIndicator(); //! Displaying a loading indicator
//             }
//             return ListView.builder(
//               itemCount: postProvider.posts.length,
//               itemBuilder: (context, index) {
//                 final PostModel post =
//                     postProvider.posts[index]; //! Extracting post object
//                 return Card(
//                   child: Column(
//                     // crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       PostDetails(post: post),
//                       ReadMoreButton(
//                         postProvider: postProvider,
//                         index: index,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
 