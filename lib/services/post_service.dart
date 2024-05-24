import '../models/post_model.dart';
import 'api_service.dart';

//! The PostService class provides post-related operations.
class PostService extends ApiService {
  //! Method to fetch posts from the API.
  Future<List<PostModel>> fetchPosts() async {
    final data = await get(
        'https://jsonplaceholder.typicode.com/posts'); //! Making an API call to fetch posts.
    return (data as List)
        .map((json) => PostModel.fromJson(json))
        .toList(); //! Parsing the posts data from the API response.
  }
}

//! Alternatively, you can do it this way
// //! The PostService class provides post-related operations.
// class PostService {
//   final ApiService apiService; //! Dependency on ApiService.

//   //! Constructor to initialize the ApiService.
//   PostService({required this.apiService});

//   //! Method to fetch posts from the API.
//   Future<List<Post>> fetchPosts() async {
//     final data = await apiService.get('https://jsonplaceholder.typicode.com/posts'); //! Making an API call to fetch posts.
//     return (data as List).map((json) => Post.fromJson(json)).toList(); //! Parsing the posts data from the API response.
//   }
// }
