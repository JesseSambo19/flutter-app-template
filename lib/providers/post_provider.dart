import 'package:flutter/foundation.dart';
import '../models/post_model.dart';
import '../services/post_service.dart';

//! The PostProvider class manages the state of the posts.
class PostProvider with ChangeNotifier {
  List<PostModel> _posts = []; //! Private variable to store the list of posts.
  final PostService postService; //! Dependency on PostService.
  int _postIndex = 0;

  //! Constructor to initialize the PostService.
  PostProvider({required this.postService});

  set setPostIndex(int value) {
    _postIndex = value;
    notifyListeners();
  }

  //! Getter to retrieve the list of posts.
  List<PostModel> get posts => _posts;

  int get getPostIndex => _postIndex;

  //! Method to fetch posts and update the state.
  Future<List<PostModel>> fetchPosts() async {
    if (kDebugMode) {
      print('PostProvider: Fetching posts...');
    }
    _posts = await postService
        .fetchPosts(); //! Fetching the posts data from the service.
        notifyListeners(); //! Notifying listeners about the state change.
    if (kDebugMode) {
      print('PostProvider: Fetched user $_posts');
    }
    return _posts;    
  }

//! Old method 
  // //! Method to fetch posts and update the state.
  // Future<void> fetchPosts() async {
  //   _posts = await postService
  //       .fetchPosts(); //! Fetching the posts data from the service.
  //   notifyListeners(); //! Notifying listeners about the state change.
  // }
}
