import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import 'api_service.dart';

//! The UserService class provides user-related operations.
class UserService extends ApiService {
  //! Method to fetch a user from the API.
  Future<UserModel> fetchUser() async {
    if (kDebugMode) {
      print('Fetching user from API');
    }
    final data = await get('https://randomuser.me/api/');
    if (kDebugMode) {
      print('Fetched data: $data');
    }
    //! Making an API call to fetch user data.
    return UserModel.fromJson(
        data['results'][0]); //! Parsing the user data from the API response.
  }
}

//! Alternatively, you can do it this way
// //! The UserService class provides user-related operations.
// class UserService {
//   final ApiService apiService; //! Dependency on ApiService.

//   //! Constructor to initialize the ApiService.
//   UserService({required this.apiService});

//   //! Method to fetch a user from the API.
//   Future<User> fetchUser() async {
//     final data = await apiService.get('https://randomuser.me/api/'); //! Making an API call to fetch user data.
//     return User.fromJson(data['results'][0]); //! Parsing the user data from the API response.
//   }
// }